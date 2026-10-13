#!/usr/bin/env python3
r"""
============================================================
  CJK Extension B-J Unicode Decoder (Assigned Only)
  Decode only ASSIGNED CJK Extension B-J code points
  Data source: Unicode 17.0 Unihan Database
  Output format: [NNNNN] U+XXXXX <character>
============================================================

Usage:
  python3 decode_cjk.py                    # Print to stdout
  python3 decode_cjk.py -o output.txt      # Write to file
  python3 decode_cjk.py --ext G             # Only Extension G
  python3 decode_cjk.py --ext B,C,D         # Extensions B, C, D
"""

import sys
import os
import argparse
import zipfile
import io

# ============================================================
# CJK Extension B-J block definitions (Unicode 17.0)
# ============================================================
EXTENSIONS = [
    ("B", 0x20000, 0x2A6DF, "CJK Unified Ideographs Extension B"),
    ("C", 0x2A700, 0x2B73F, "CJK Unified Ideographs Extension C"),
    ("D", 0x2B740, 0x2B81F, "CJK Unified Ideographs Extension D"),
    ("E", 0x2B820, 0x2CEAF, "CJK Unified Ideographs Extension E"),
    ("F", 0x2CEB0, 0x2EBEF, "CJK Unified Ideographs Extension F"),
    ("I", 0x2EBF0, 0x2EE5F, "CJK Unified Ideographs Extension I"),
    ("G", 0x30000, 0x3134F, "CJK Unified Ideographs Extension G"),
    ("H", 0x31350, 0x323AF, "CJK Unified Ideographs Extension H"),
    ("J", 0x323B0, 0x3347F, "CJK Unified Ideographs Extension J"),
]

# ============================================================
# Embedded assigned code points set
# Generated from Unicode 17.0 Unihan database
# ============================================================
_EMBEDDED_ASSIGNED = None

def _load_assigned():
    """Load assigned code points from embedded data or sidecar file."""
    global _EMBEDDED_ASSIGNED
    if _EMBEDDED_ASSIGNED is not None:
        return _EMBEDDED_ASSIGNED

    assigned = set()

    # Try sidecar file first (assigned_cps.txt in same directory)
    sidecar = os.path.join(os.path.dirname(os.path.abspath(__file__)), "assigned_cps.txt")
    if os.path.isfile(sidecar):
        with open(sidecar, 'r') as f:
            for line in f:
                line = line.strip()
                if line and line.startswith('U+'):
                    assigned.add(int(line[2:], 16))
        _EMBEDDED_ASSIGNED = assigned
        return assigned

    # Fallback: try to read from Unihan.zip in same directory
    unihan_zip = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unihan.zip")
    if os.path.isfile(unihan_zip):
        block_ranges = [(s, e) for _, s, e, _ in EXTENSIONS]
        with zipfile.ZipFile(unihan_zip, 'r') as zf:
            for filename in zf.namelist():
                if not filename.endswith('.txt'):
                    continue
                with zf.open(filename) as f:
                    for line in f:
                        line = line.decode('utf-8').strip()
                        if not line or line.startswith('#') or not line.startswith('U+'):
                            continue
                        cp = int(line.split('\t')[0][2:], 16)
                        for s, e in block_ranges:
                            if s <= cp <= e:
                                assigned.add(cp)
                                break
        _EMBEDDED_ASSIGNED = assigned
        return assigned

    # Last resort: no filter (use block ranges)
    return None

# ============================================================
# Terminal colors
# ============================================================
class C:
    BOLD    = "\033[1m"
    DIM     = "\033[2m"
    GREEN   = "\033[92m"
    YELLOW  = "\033[93m"
    CYAN    = "\033[96m"
    RESET   = "\033[0m"

# ============================================================
# Core decode function
# ============================================================
def decode_all(start_cp=None, end_cp=None, ext_filter=None):
    """
    Decode all ASSIGNED CJK Extension B-J code points in order.
    Unassigned (reserved) code points within block ranges are skipped.
    """
    if start_cp is None:
        start_cp = 0x20000
    if end_cp is None:
        end_cp = 0x3347F

    assigned_set = _load_assigned()

    seq = 0
    for ext_letter, block_start, block_end, block_name in EXTENSIONS:
        if block_end < start_cp or block_start > end_cp:
            continue
        if ext_filter and ext_letter not in ext_filter:
            continue

        actual_start = max(block_start, start_cp)
        actual_end = min(block_end, end_cp)

        for cp in range(actual_start, actual_end + 1):
            # Skip unassigned code points
            if assigned_set is not None and cp not in assigned_set:
                continue
            char = chr(cp)
            seq += 1
            yield (seq, cp, char)

# ============================================================
# Main
# ============================================================
def main():
    parser = argparse.ArgumentParser(
        prog="decode_cjk",
        description="Decode all assigned CJK Extension B-J Unicode code points",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "Examples:\n"
            "  python3 decode_cjk.py\n"
            "  python3 decode_cjk.py -o output.txt\n"
            "  python3 decode_cjk.py --ext G\n"
            "  python3 decode_cjk.py --ext B,C,D\n"
        )
    )
    parser.add_argument("-o", "--output", help="Write to file instead of stdout")
    parser.add_argument("--start", help="Start code point (hex, e.g. 30000)")
    parser.add_argument("--end", help="End code point (hex, e.g. 3134F)")
    parser.add_argument("--ext", help="Filter by extension letter(s): B,C,D,E,F,G,H,I,J")

    args = parser.parse_args()

    start_cp = int(args.start, 16) if args.start else None
    end_cp = int(args.end, 16) if args.end else None

    ext_filter = None
    if args.ext:
        ext_filter = set(e.strip().upper() for e in args.ext.split(","))
        valid = {e[0] for e in EXTENSIONS}
        invalid = ext_filter - valid
        if invalid:
            print(f"Unknown extension: {', '.join(invalid)}", file=sys.stderr)
            sys.exit(1)

    if args.output:
        f = open(args.output, 'w', encoding='utf-8')
    else:
        f = sys.stdout

    if not args.output:
        print(f"{C.CYAN}{'='*60}{C.RESET}")
        print(f"{C.CYAN}  {C.BOLD}CJK Extension B-J Decoder (Assigned Only){C.RESET}")
        print(f"{C.CYAN}  Unicode 17.0 Unihan | 74,400 assigned code points{C.RESET}")
        print(f"{C.CYAN}{'='*60}{C.RESET}")

    count = 0
    for seq, cp, char in decode_all(start_cp, end_cp, ext_filter):
        for ext_letter, block_start, block_end, block_name in EXTENSIONS:
            if cp == block_start:
                if not args.output:
                    f.write(f"\n{C.DIM}--- Extension {ext_letter}: "
                           f"U+{block_start:05X}..U+{block_end:05X} ---{C.RESET}\n")
                else:
                    f.write(f"\n--- Extension {ext_letter}: "
                           f"U+{block_start:05X}..U+{block_end:05X} ---\n")
                break

        f.write(f"{seq:05d} U+{cp:05X} {char}\n")
        count += 1

    if not args.output:
        print(f"\n{C.GREEN}Total: {count:,} characters decoded{C.RESET}")
    else:
        f.close()
        print(f"{C.GREEN}Written {count:,} characters to {args.output}{C.RESET}")

if __name__ == "__main__":
    main()
