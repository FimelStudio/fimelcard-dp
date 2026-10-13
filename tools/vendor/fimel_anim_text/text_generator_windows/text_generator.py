#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import tkinter as tk
from tkinter import colorchooser
import random
import sys


class MinecraftTextGenerator:
    def __init__(self, root):
        self.root = root
        self.root.title("Minecraft Text Generator")
        self.root.configure(bg="#2b2b2b")

        # 窗口尺寸与居中
        window_width = 640
        window_height = 800
        screen_width = root.winfo_screenwidth()
        screen_height = root.winfo_screenheight()
        x = (screen_width - window_width) // 2
        y = (screen_height - window_height) // 2
        self.root.geometry(f"{window_width}x{window_height}+{x}+{y}")
        self.root.resizable(False, False)

        # 浮窗置顶
        self.root.attributes("-topmost", True)

        # 禁用关闭按钮（保留 Alt+F4）
        self.disable_close_button()
        self.root.protocol("WM_DELETE_WINDOW", lambda: None)

        # 样式状态
        self.current_color = "#ffffff"
        self.obfuscated_running = False
        self.obfuscated_chars = {}   # {str(index): original_char}
        self.color_tags = set()
        self.font_family = "Consolas"
        self.font_size = 12

        self.setup_ui()
        self.bind_events()

    # ------------------------------------------------------------------
    # 窗口控制
    # ------------------------------------------------------------------
    def disable_close_button(self):
        """禁用标题栏关闭按钮（X），Alt+F4 仍可用"""
        if sys.platform == "win32":
            try:
                import ctypes
                hwnd = ctypes.windll.user32.GetForegroundWindow()
                if hwnd:
                    hMenu = ctypes.windll.user32.GetSystemMenu(hwnd, False)
                    if hMenu:
                        ctypes.windll.user32.DeleteMenu(hMenu, 0xF060, 0)
                        ctypes.windll.user32.DrawMenuBar(hwnd)
            except Exception:
                pass

    # ------------------------------------------------------------------
    # UI 构建
    # ------------------------------------------------------------------
    def setup_ui(self):
        main_container = tk.Frame(self.root, bg="#2b2b2b", padx=20, pady=20)
        main_container.pack(fill=tk.BOTH, expand=True)

        # ---------- 调节栏 (600x60) ----------
        toolbar = tk.Frame(main_container, bg="#3b3b3b", width=600, height=60)
        toolbar.pack_propagate(False)
        toolbar.pack(fill=tk.X, pady=(0, 10))

        # 颜色按钮
        self.color_btn = tk.Button(
            toolbar, bg=self.current_color, relief=tk.RAISED,
            command=self.choose_color
        )
        self.color_btn.place(x=10, y=10, width=60, height=40)

        # 斜体
        self.italic_btn = tk.Button(
            toolbar, text="I", bg="#4b4b4b", fg="white",
            font=(self.font_family, 10, "italic"),
            command=lambda: self.toggle_style("italic")
        )
        self.italic_btn.place(x=80, y=10, width=60, height=40)

        # 加粗
        self.bold_btn = tk.Button(
            toolbar, text="B", bg="#4b4b4b", fg="white",
            font=(self.font_family, 10, "bold"),
            command=lambda: self.toggle_style("bold")
        )
        self.bold_btn.place(x=150, y=10, width=60, height=40)

        # 下划线
        self.underline_btn = tk.Button(
            toolbar, text="U", bg="#4b4b4b", fg="white",
            font=(self.font_family, 10, "underline"),
            command=lambda: self.toggle_style("underlined")
        )
        self.underline_btn.place(x=220, y=10, width=60, height=40)

        # 删除线
        self.strike_btn = tk.Button(
            toolbar, text="S", bg="#4b4b4b", fg="white",
            font=(self.font_family, 10),
            command=lambda: self.toggle_style("strikethrough")
        )
        self.strike_btn.place(x=290, y=10, width=60, height=40)

        # 随机字符 (obfuscated)
        self.obf_btn = tk.Button(
            toolbar, text="O", bg="#4b4b4b", fg="white",
            font=(self.font_family, 10),
            command=lambda: self.toggle_style("obfuscated")
        )
        self.obf_btn.place(x=360, y=10, width=60, height=40)

        # 确认生成
        self.generate_btn = tk.Button(
            toolbar, text="确认生成", bg="#4b4b4b", fg="white",
            font=(self.font_family, 9),
            command=self.generate_snbt
        )
        self.generate_btn.place(x=530, y=10, width=60, height=40)

        # ---------- 文本框 (600x360) ----------
        editor_outer = tk.Frame(main_container, bg="white", width=600, height=360)
        editor_outer.pack_propagate(False)
        editor_outer.pack(fill=tk.X, pady=(0, 10))

        self.text_editor = tk.Text(
            editor_outer, width=1, height=1,
            bg="#1e1e1e", fg="gray",
            insertbackground="white",
            selectbackground="white", selectforeground="black",
            font=(self.font_family, self.font_size),
            wrap=tk.WORD, relief=tk.FLAT, borderwidth=0,
            padx=10, pady=10,
            undo=True
        )
        self.text_editor.pack(fill=tk.BOTH, expand=True, padx=1, pady=1)
        self.text_editor.insert("1.0", "点击输入文本…")

        # ---------- 输出栏 (600x300) ----------
        self.output_frame = tk.Frame(main_container, bg="#2b2b2b", width=600, height=300)
        self.output_frame.pack_propagate(False)
        # 初始不显示

        output_inner = tk.Frame(self.output_frame, bg="#323232", padx=1, pady=1)
        output_inner.pack(fill=tk.BOTH, expand=True)

        self.output_text = tk.Text(
            output_inner, width=1, height=1,
            bg="#323232", fg="white",
            font=(self.font_family, 10),
            wrap=tk.WORD, relief=tk.FLAT, borderwidth=0,
            padx=10, pady=10,
            state=tk.DISABLED
        )
        self.output_text.pack(fill=tk.BOTH, expand=True)

        # 复制按钮
        copy_btn = tk.Button(
            self.output_frame, text="复制", bg="#4b4b4b", fg="white",
            font=(self.font_family, 9),
            command=self.copy_output
        )
        copy_btn.place(relx=1.0, rely=1.0, anchor="se", x=-15, y=-15)

    # ------------------------------------------------------------------
    # 事件绑定
    # ------------------------------------------------------------------
    def bind_events(self):
        # 占位符
        self.text_editor.bind("<FocusIn>", self.on_focus_in)
        self.text_editor.bind("<FocusOut>", self.on_focus_out)

        # 输入拦截
        self.text_editor.bind('"', self.on_quote_input)
        self.text_editor.bind("<Return>", self.on_return_input)
        self.text_editor.bind("<KP_Enter>", self.on_return_input)

        # 修改输入栏时隐藏输出栏
        self.text_editor.bind("<Key>", self.on_text_modified_event)
        self.text_editor.bind("<Button-1>", self.on_text_modified_event)
        self.text_editor.bind("<Button-2>", self.on_text_modified_event)
        self.text_editor.bind("<Button-3>", self.on_text_modified_event)

        # 样式 tag 预设
        self.text_editor.tag_configure(
            "italic", font=(self.font_family, self.font_size, "italic")
        )
        self.text_editor.tag_configure(
            "bold", font=(self.font_family, self.font_size, "bold")
        )
        self.text_editor.tag_configure("underlined", underline=True)
        self.text_editor.tag_configure("strikethrough", overstrike=True)
        self.text_editor.tag_configure(
            "obfuscated", background="#4b0082"
        )

    # ------------------------------------------------------------------
    # 占位符逻辑
    # ------------------------------------------------------------------
    def on_focus_in(self, event):
        if self.text_editor.get("1.0", "end-1c") == "点击输入文本…":
            self.text_editor.delete("1.0", "end")
            self.text_editor.config(fg="white")

    def on_focus_out(self, event):
        if not self.text_editor.get("1.0", "end-1c").strip():
            self.text_editor.delete("1.0", "end")
            self.text_editor.insert("1.0", "点击输入文本…")
            self.text_editor.config(fg="gray")

    # ------------------------------------------------------------------
    # 输入拦截（引号、回车）
    # ------------------------------------------------------------------
    def on_quote_input(self, event):
        self.text_editor.insert("insert", "\\\"")
        return "break"

    def on_return_input(self, event):
        self.text_editor.insert("insert", "\\n")
        return "break"

    def on_text_modified_event(self, event):
        if self.output_frame.winfo_ismapped():
            self.output_frame.pack_forget()

    # ------------------------------------------------------------------
    # 颜色选择
    # ------------------------------------------------------------------
    def choose_color(self):
        color = colorchooser.askcolor(
            initialcolor=self.current_color, title="选择颜色 (#RRGGBB)"
        )
        if color[1]:
            self.current_color = color[1]
            self.color_btn.config(bg=self.current_color)
            self.apply_color(self.current_color)

    def apply_color(self, color):
        try:
            start = self.text_editor.index("sel.first")
            end = self.text_editor.index("sel.last")
        except tk.TclError:
            return

        # 移除选区内所有旧颜色 tag
        for tag in list(self.color_tags):
            self.text_editor.tag_remove(tag, start, end)

        tag_name = f"color_{color}"
        self.text_editor.tag_configure(tag_name, foreground=color)
        self.text_editor.tag_add(tag_name, start, end)
        self.color_tags.add(tag_name)

    # ------------------------------------------------------------------
    # 样式切换（斜体/加粗/下划线/删除线/随机字符）
    # ------------------------------------------------------------------
    def toggle_style(self, style_name):
        try:
            start = self.text_editor.index("sel.first")
            end = self.text_editor.index("sel.last")
        except tk.TclError:
            return

        current_tags = self.text_editor.tag_names(start)
        has_tag = style_name in current_tags

        if has_tag:
            self.text_editor.tag_remove(style_name, start, end)
            if style_name == "obfuscated":
                self._restore_obfuscated_range(start, end)
        else:
            self.text_editor.tag_add(style_name, start, end)
            if style_name == "obfuscated":
                if not self.obfuscated_running:
                    self.start_obfuscated_animation()

    # ------------------------------------------------------------------
    # Obfuscated（随机字符）动画
    # ------------------------------------------------------------------
    def _restore_obfuscated_range(self, start, end):
        pos = start
        while self.text_editor.compare(pos, "<", end):
            key = str(pos)
            if key in self.obfuscated_chars:
                original = self.obfuscated_chars[key]
                current = self.text_editor.get(pos, f"{pos} + 1 chars")
                if current != original:
                    self.text_editor.delete(pos, f"{pos} + 1 chars")
                    self.text_editor.insert(pos, original, "obfuscated")
            pos = self.text_editor.index(f"{pos} + 1 chars")

    def _restore_all_obfuscated(self):
        ranges = self.text_editor.tag_ranges("obfuscated")
        self._restore_obfuscated_ranges(ranges)

    def _restore_obfuscated_ranges(self, ranges):
        for i in range(0, len(ranges), 2):
            self._restore_obfuscated_range(ranges[i], ranges[i + 1])

    def start_obfuscated_animation(self):
        self.obfuscated_running = True
        self._animate_obfuscated()

    def _animate_obfuscated(self):
        if not self.obfuscated_running:
            return

        ranges = self.text_editor.tag_ranges("obfuscated")
        if not ranges:
            self.obfuscated_running = False
            self.obfuscated_chars.clear()
            return

        # 若光标或选区落在 obfuscated 区域内，则暂停动画并恢复原文
        insert_pos = self.text_editor.index("insert")
        cursor_inside = False

        for i in range(0, len(ranges), 2):
            r_start, r_end = ranges[i], ranges[i + 1]
            if (self.text_editor.compare(insert_pos, ">=", r_start) and
                    self.text_editor.compare(insert_pos, "<", r_end)):
                cursor_inside = True
                break

        try:
            sel_start = self.text_editor.index("sel.first")
            sel_end = self.text_editor.index("sel.last")
            for i in range(0, len(ranges), 2):
                r_start, r_end = ranges[i], ranges[i + 1]
                if not (self.text_editor.compare(sel_end, "<=", r_start) or
                        self.text_editor.compare(sel_start, ">=", r_end)):
                    cursor_inside = True
                    break
        except tk.TclError:
            pass

        if not cursor_inside:
            self._update_obfuscated_chars(ranges)
        else:
            self._restore_obfuscated_ranges(ranges)

        self.root.after(100, self._animate_obfuscated)

    def _update_obfuscated_chars(self, ranges):
        for i in range(0, len(ranges), 2):
            start = ranges[i]
            end = ranges[i + 1]
            pos = start
            while self.text_editor.compare(pos, "<", end):
                char = self.text_editor.get(pos, f"{pos} + 1 chars")
                key = str(pos)

                if key not in self.obfuscated_chars:
                    self.obfuscated_chars[key] = char

                original = self.obfuscated_chars[key]
                random_char = self._get_random_char(original)

                if char != random_char:
                    self.text_editor.delete(pos, f"{pos} + 1 chars")
                    self.text_editor.insert(pos, random_char, "obfuscated")

                pos = self.text_editor.index(f"{pos} + 1 chars")

    def _get_random_char(self, original):
        # 从等宽可打印 ASCII 中随机选取，保持视觉宽度大致一致
        pool = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                "abcdefghijklmnopqrstuvwxyz0123456789")
        return random.choice(pool)

    # ------------------------------------------------------------------
    # SNBT 生成
    # ------------------------------------------------------------------
    def generate_snbt(self):
        # 生成前先把 obfuscated 区域恢复为原文，保证索引一致
        self._restore_all_obfuscated()

        text = self.text_editor.get("1.0", "end-1c")
        if text == "点击输入文本…" or not text:
            return

        components = []
        i = 0
        length = len(text)

        while i < length:
            char = text[i]

            # 识别转义序列
            if char == '\\' and i + 1 < length:
                nxt = text[i + 1]

                if nxt == 'n':
                    components.append(self._build_component("\\n", i, i + 2))
                    i += 2
                    continue
                elif nxt == '"':
                    components.append(self._build_component('\\"', i, i + 2))
                    i += 2
                    continue
                elif nxt == 'u' and i + 5 < length:
                    hex_part = text[i + 2:i + 6]
                    if all(ch in '0123456789abcdefABCDEF' for ch in hex_part):
                        components.append(
                            self._build_component("\\u" + hex_part, i, i + 6)
                        )
                        i += 6
                        continue

            # 普通单字
            components.append(self._build_component(char, i, i + 1))
            i += 1

        result = "[" + ",".join(components) + "]"

        # 显示输出栏
        self.output_text.config(state=tk.NORMAL)
        self.output_text.delete("1.0", "end")
        self.output_text.insert("1.0", result)
        self.output_text.config(state=tk.DISABLED)
        self.output_frame.pack(fill=tk.BOTH, expand=True, pady=(10, 0))

    def _build_component(self, char_text, start_idx, end_idx):
        # 取中间位置查询样式 tag
        mid = (start_idx + end_idx - 1) // 2
        pos = f"1.0 + {mid} chars"

        color = "#ffffff"
        italic = bold = underlined = strikethrough = obfuscated = False

        for tag in self.text_editor.tag_names(pos):
            if tag.startswith("color_"):
                color = tag.split("_", 1)[1]
            elif tag == "italic":
                italic = True
            elif tag == "bold":
                bold = True
            elif tag == "underlined":
                underlined = True
            elif tag == "strikethrough":
                strikethrough = True
            elif tag == "obfuscated":
                obfuscated = True

        escaped = self._escape_snbt(char_text)
        return (
            f'{{text:"{escaped}",color:"{color}",'
            f'italic:{str(italic).lower()},bold:{str(bold).lower()},'
            f'underlined:{str(underlined).lower()},'
            f'strikethrough:{str(strikethrough).lower()},'
            f'obfuscated:{str(obfuscated).lower()}}}'
        )

    def _escape_snbt(self, s):
        out = []
        for ch in s:
            if ch == '\\':
                out.append('\\\\')
            elif ch == '"':
                out.append('\\"')
            else:
                out.append(ch)
        return ''.join(out)

    # ------------------------------------------------------------------
    # 复制输出
    # ------------------------------------------------------------------
    def copy_output(self):
        text = self.output_text.get("1.0", "end-1c")
        self.root.clipboard_clear()
        self.root.clipboard_append(text)

    # ------------------------------------------------------------------
    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    root = tk.Tk()
    app = MinecraftTextGenerator(root)
    app.run()
