package I18n;

use strict;
use warnings;
use utf8;

sub new {
    my $class = shift;
    my $self = bless {};

    $self->{langs}   = [qw(English 中文)];
    $self->{lang}    = 1;  # default language

    $self->{string}  = undef;
    $self->{all_string} = {
        title => [
            "   Test Your Key Learning!",
            "       调式知识小测验！",
        ],
        quiz => [
            "Q-%d: Sharp/Flat note(s) of '%s'?\n",
            "Q-%d: '%s' 的调式升降是？\n",
        ],
        answer_is => [
            "[Answer is '%s']\n",
            "[正确答案是 '%s']\n",
        ],
        wrong_answer => [
            "wrong answer",
            "回答错误",
        ],
        hint_message => [
            <<EOF,
|  ♯: 4-1-5-2-6-3-7
|     look for the next whole tone
|       e.g. (F)4♯ -> G major
|  ♭: 7-3-6-2-5-1-4
|     check the previous '♭' signature
|       e.g. 2♭ -> B(7) major
|       spacial: 1♭ is F major
EOF
            <<EOF,
|  ♯: 4-1-5-2-6-3-7
|     找下一个全音
|       例：(F)4♯ -> G 大调
|  ♭: 7-3-6-2-5-1-4
|     看前一个降号
|       例：2♭ -> B(7) 大调
|       特殊：1♭ 是 F 大调
EOF
        ],
        hint => [
            "HINT",
            "提示",
        ],
        help_message => [
            <<EOF,
|  '0'   for C major (no '♯' or '♭')
|  '1#'  for 1 '♯'
|  '2b'  for 2 '♭'s
|        and so on.
|  '!'   to skip
|  'h'   to show HINT
|  'c'   to toggle language (en/中)
|  'q'   to quit
EOF
            <<EOF,
|  '0'   表示 C 大调（无升降号）
|  '1#'  表示 1 个升号
|  '2b'  表示 2 个降号
|        以此类推。
|  '!'   跳过本题
|  'h'   查看提示
|  'c'   切换语言（en/中）
|  'q'   退出
EOF
        ],
        help => [
            "help",
            "帮助",
        ],
        set_lang_to => [
            "[Language is set to: %s]\n",
            "[语言设置为：%s]\n",
        ],
    };

    # initialize $self->{string}
    set_lang($self, $self->{lang}, 1) or die "ERROR: invalid language index";

    return $self;
}

sub set_lang {
    my ($self, $lang, $force) = @_;
    return if ($lang < 0 || $lang >= @{$self->{langs}});
    return 1 if ($self->{lang} == $lang && !defined $force);  # no change

    $self->{lang} = $lang;
    foreach (keys %{$self->{all_string}}) {
        $self->{string}{$_} = $self->{all_string}{$_}[$self->{lang}];
    }
    return 1;
}

sub loop_langs {
    my $self = shift;
    $self->set_lang( ($self->{lang} + 1) % @{$self->{langs}} );
    return $self->{langs}[$self->{lang}];
}

sub fix_gbk {
    my $self = shift;
    foreach (keys %{$self->{all_string}}) {
        my $aref = \@{$self->{all_string}{$_}};
        for my $i (0 .. $#{$aref}) {
            my $t = $aref->[$i];
            next if ($t !~ /♯|♭/);
            $t =~ tr/♯♭/#b/;
            $aref->[$i] = $t;
        }
    }
    set_lang($self, $self->{lang}, 1) or die "ERROR: invalid language index";
}

1;
