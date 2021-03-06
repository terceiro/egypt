package ExtractorTests;
use base qw(Test::Class);
use Test::More 'no_plan'; # REMOVE THE 'no_plan'
use Test::Exception;

use strict;
use warnings;

BEGIN {
   use_ok 'Egypt::Extractor';
}

eval('$Egypt::Extractor::QUIET = 1;'); # the eval is to avoid Test::* complaining about possible typo

sub constructor : Tests {
  isa_ok(new Egypt::Extractor, 'Egypt::Extractor');
}

sub has_a_current_member : Tests {
  can_ok('Egypt::Extractor', 'current_member');
}

##############################################################################
# BEGIN test of indicating current module
##############################################################################
sub current_module : Tests {
  my $extractor = new Egypt::Extractor;
  $extractor->current_module('module1.c');
  is($extractor->current_module, 'module1.c', 'must be able to set the current module');
  $extractor->current_module('module2.c');
  is($extractor->current_module, 'module2.c', 'must be able to change the current module');
}

sub process_must_be_overwriten_in_a_subclass : Tests {
  dies_ok { Egypt::Extractor->new->process };
}

sub load_doxyparse_extractor : Tests {
  lives_ok { Egypt::Extractor->load('Doxyparse') };
}

sub fail_when_load_invalid_extractor : Tests {
  dies_ok { Egypt::Extractor->load('ThisNotExists') };
}

sub load_doxyparse_extractor_by_alias : Tests {
  lives_ok {
    isa_ok(Egypt::Extractor->load('doxy'), 'Egypt::Extractor::Doxyparse');
  }
}

ExtractorTests->runtests;
