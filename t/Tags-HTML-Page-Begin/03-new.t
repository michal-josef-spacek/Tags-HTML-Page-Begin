use strict;
use warnings;

use CSS::Struct::Output::Raw;
use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Page::Begin;
use Tags::Output::Raw;
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::Page::Begin->new(
	'tags' => Tags::Output::Raw->new,
);
isa_ok($obj, 'Tags::HTML::Page::Begin');

# Test.
$obj = Tags::HTML::Page::Begin->new(
	'css' => CSS::Struct::Output::Raw->new,
	'tags' => Tags::Output::Raw->new,
);
isa_ok($obj, 'Tags::HTML::Page::Begin');

# Test.
eval {
	Tags::HTML::Page::Begin->new;
};
is(
	$EVAL_ERROR,
	"Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Missing required parameter 'tags'.",
);
clean();

# Test.
eval {
	Tags::HTML::Page::Begin->new(
		'tags' => Tags::HTML::Page::Begin->new(
			'tags' => Tags::Output::Raw->new,
		),
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Bad 'Tags::Output' instance.",
);
clean();

# Test.
eval {
	Tags::HTML::Page::Begin->new(
		'css' => Tags::Output::Raw->new,
		'tags' => Tags::Output::Raw->new,
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class.\n",
	"Bad 'CSS::Struct::Output' instance.",
);
clean();
