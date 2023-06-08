#!/usr/bin/env -S perl -CSDA

use strict;
use warnings;
use utf8;
use lib qw(.);
use I18n;

my %scales = (
    "C"  => "0",
    # all '♯'s
    G    => "1#",
    D    => "2#",
    A    => "3#",
    E    => "4#",
    B    => "5#",
    "♯F" => "6#",
    "♯C" => "7#",
    # all '♭'s
    F    => "1b",
    "♭B" => "2b",
    "♭E" => "3b",
    "♭A" => "4b",
    "♭D" => "5b",
    "♭G" => "6b",
    "♭C" => "7b",
);

my $i18n = I18n->new();
my $quiz;
my $ans;
my $last_quiz_0 = "";
my $last_quiz_1 = "";

sub rand_hash {
    my $href = shift;
    my @keys = keys %$href;
    my $rand_key = $keys[rand @keys];
    return ($rand_key, $href->{$rand_key});
}

sub gen_new_quiz {
    do {
        ($quiz, $ans) = rand_hash(\%scales);
    } while ($quiz eq $last_quiz_0 || $quiz eq $last_quiz_1);
    $last_quiz_1 = $last_quiz_0;  # store last 2 selections
    $last_quiz_0 = $quiz;
}

sub print_title {
    print <<EOF;
-----------------------------
$i18n->{string}{title}
-----------------------------
EOF
}

sub fix_gbk {
    binmode(STDOUT, ":encoding(gbk)");
    foreach (keys %scales) {
        next if ($_ !~ /♯|♭/);
        my $v = $scales{$_};
        delete $scales{$_};
        $_ =~ tr/♯♭/#b/;
        $scales{$_} = $v;
    }
    $i18n->fix_gbk();
}

foreach (@ARGV) {
    $i18n->set_lang(0) if ($_ eq "-en");
    $i18n->set_lang(1) if ($_ eq "-zh");
    fix_gbk() if ($_ eq "-gbk");
}

my $exit = 0;
my $i = 1;

print_title();

# main loop
while ($exit == 0) {
    gen_new_quiz();
    print (sprintf $i18n->{string}{quiz}, $i, $quiz);
    print "A: ";
    while (<STDIN>) {
        $_ =~ s/^\s+|\s+$//g;
        if ($_ eq "q") {
            $exit = 1;
            last;
        }

        if ($_ =~ /^[1-7][#b]$|^0$/ || $_ eq "!") {
            if ($_ eq "!") {
                print (sprintf $i18n->{string}{answer_is}, $ans);
                print "-----------------------------\n";
                last;
            }
            if ($_ eq $ans) {
                print "-----------------------------\n";
                last;
            }
            print "[$i18n->{string}{wrong_answer}] A: ";

        } elsif ($_ eq "h") {
            # show HINT
            print "$i18n->{string}{hint_message}";
            print "[$i18n->{string}{hint}] A: ";

        } elsif ($_ eq "c") {
            # loop languages
            my $new_lang = $i18n->loop_langs();
            print_title();
            print (sprintf $i18n->{string}{set_lang_to}, $new_lang);
            print (sprintf $i18n->{string}{quiz}, $i, $quiz);
            print "A: ";

        } else {
            # show help message
            print "$i18n->{string}{help_message}";
            print "[$i18n->{string}{help}] A: ";
        }
    }
    $i++;
}
