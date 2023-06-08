# Key Signature Test

[English] [[简体中文]](./Readme_zh.md)

Test your key signature learning in the terminal!

## Background

I always have an interest in script languages like Bash, to provide an
OS-wide ability to run tasks. Bash was my choice, and it works kinda well
on Linux. But when I turn to Windows, which I use the most often, it sucks.
I never want to use WSL to run some toy scripts, and Bash emulators are
just slow and unsatisfying.

Python is great but still kind of *huge*, especially when I just want some
text manipulations in the terminal.

Perl is widely used in my recent project in my job. It seems to be a *better*
Bash and is very appealing to me. Also, Strawberry Perl (Perl environment
on Windows) works just like how Perl on Linux does. So I speedrun Perl
tutorials these two days and wrote this tiny program as a practice. It's
so fun to have powerful regex support and explore sigil usages, while it's
just so weird to write a class/package in Perl.

And oh, I'm learning piano from scratch. So, key signatures!

## Usage

By default, it runs on Simplified Chinese.

```
./test.pl [-gbk] [-zh] [-en]
    -gbk    use gbk encoding instead of utf8 for output
            (usually you never need this)
            ps. Simplified Chinese Windows sucks.
    -zh     set language to Simplified Chinese
    -en     set language to English
```

On Windows, you may need to do:

```
perl -CSDA ./test.pl [other_arguments]
```

to run correctly.

When in the test, submit anything invalid to show the help message.
