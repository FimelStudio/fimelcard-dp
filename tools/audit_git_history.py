"""只读标记 Git 合并中的旧版本覆盖和已淘汰文件重现。

例：python tools/audit_git_history.py --base f60505d --candidate HEAD
暂存修复后可将 candidate 设为 INDEX。脚本不会 checkout、删文件或合并；
历史命中是审查线索，合法回退也需人工核对，不自动恢复整个旧目录。
"""
from pathlib import Path
import argparse
import collections
import json
import subprocess
import sys


def inspect(repo, base, candidate):
    def git(*args):
        return subprocess.check_output(['git','-C',str(repo),*args],stderr=subprocess.PIPE)

    def tree(ref, paths=None):
        args=['ls-tree','-r','-z',ref]
        if paths:args+=['--',*paths]
        result={}
        for row in git(*args).split(b'\0'):
            if not row:continue
            metadata,path=row.split(b'\t',1)
            mode,kind,blob=metadata.decode('ascii').split()
            if kind=='blob':result[path.decode('utf-8')]=blob
        return result

    base_hash=git('rev-parse','--verify',base+'^{commit}').decode().strip()
    good=tree(base_hash)
    if candidate.upper()=='INDEX':
        tip='INDEX';current={}
        for row in git('ls-files','--stage','-z').split(b'\0'):
            if not row:continue
            metadata,path=row.split(b'\t',1)
            mode,blob,stage=metadata.decode('ascii').split()
            if stage!='0':raise ValueError('暂存区仍有未解决的合并冲突')
            current[path.decode('utf-8')]=blob
    else:
        tip=git('rev-parse','--verify',candidate+'^{commit}').decode().strip()
        current=tree(tip)
    changed=sorted(p for p in good.keys()|current.keys() if good.get(p)!=current.get(p))
    pending={p for p in changed if p in current}
    matches={}
    for revision in git('rev-list',base_hash).decode('ascii').splitlines()[1:]:
        if not pending:break
        # 分批传路径，兼容 Windows 命令行长度上限。
        paths=sorted(pending)
        for offset in range(0,len(paths),96):
            for p,blob in tree(revision,paths[offset:offset+96]).items():
                if p in pending and current[p]==blob:
                    matches[p]=revision;pending.remove(p)
    rows=[]
    for p in changed:
        status='added' if p not in good else 'deleted' if p not in current else 'modified'
        finding='deleted' if status=='deleted' else ('resurrected' if status=='added' else 'rewind') if p in matches else 'changed'
        rows.append({'path':p,'status':status,'finding':finding,'base_blob':good.get(p),'candidate_blob':current.get(p),'earlier_match':matches.get(p)})
    return {'repo':str(repo.resolve()),'base':base_hash,'candidate':tip,
            'counts':dict(collections.Counter(r['finding'] for r in rows)),'files':rows,
            'note':'比较提交或暂存区的 Git blob；未暂存的编辑不在检查范围内。历史命中与删除须人工判断。'}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo',type=Path,default=Path.cwd())
    parser.add_argument('--base',required=True,help='已确认正确的提交')
    parser.add_argument('--candidate',default='HEAD',help='待审查提交，或已暂存的 INDEX')
    parser.add_argument('--output',type=Path,help='保存完整 UTF-8 JSON 报告')
    parser.add_argument('--details-limit',type=int,default=20,help='最多输出多少条明细，完整报告不截断')
    parser.add_argument('--fail-on-rewind',action='store_true',help='旧内容回退或历史文件重现时返回非零；删除仍需人工检查')
    args=parser.parse_args()
    try:report=inspect(args.repo,args.base,args.candidate)
    except (subprocess.CalledProcessError,ValueError) as error:
        detail=error.stderr.decode('utf-8',errors='replace') if isinstance(error,subprocess.CalledProcessError) else str(error)
        print(detail,file=sys.stderr);return 2
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'base':report['base'],'candidate':report['candidate'],'counts':report['counts']},ensure_ascii=False))
    findings=[r for r in report['files'] if r['finding'] in ('rewind','resurrected','deleted')]
    for row in findings[:max(0,args.details_limit)]:
        print(row['finding'],row['path'],(row['earlier_match'] or '')[:10])
    if len(findings)>max(0,args.details_limit):
        print('其余',len(findings)-max(0,args.details_limit),'项见 --output 完整报告。')
    return int(args.fail_on_rewind and any(r['finding'] in ('rewind','resurrected') for r in report['files']))


if __name__=='__main__':raise SystemExit(main())
