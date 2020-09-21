use strict;
use warnings;

use CSS::Struct::Output::Raw;
use Tags::HTML::Page::Begin;
use Tags::Output::Structure;
use Test::More 'tests' => 7;
use Test::NoWarnings;

# Test.
my $tags = Tags::Output::Structure->new;
my $obj = Tags::HTML::Page::Begin->new(
	'tags' => $tags,
);
$obj->process;
my $ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['r', '<!DOCTYPE html>'],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],

		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'charset', 'UTF-8'],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'name', 'generator'],
		['a', 'content', 'Perl module: Tags::HTML::Page::Begin, Version: '.
			$Tags::HTML::Page::Begin::VERSION],
		['e', 'meta'],

		['b', 'title'],
		['d', 'Page title'],
		['e', 'title'],

		['e', 'head'],
		['b', 'body'],
	],
	'Begin of page with default without CSS.',
);

# Test.
$tags = Tags::Output::Structure->new;
$obj = Tags::HTML::Page::Begin->new(
	'charset' => undef,
	'generator' => undef,
	'tags' => $tags,
);
$obj->process;
$ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['r', '<!DOCTYPE html>'],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],

		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],

		['b', 'title'],
		['d', 'Page title'],
		['e', 'title'],

		['e', 'head'],
		['b', 'body'],
	],
	'Begin of page without charset and generator and without CSS.',
);

# Test.
my $css = CSS::Struct::Output::Raw->new;
$obj = Tags::HTML::Page::Begin->new(
	'css' => $css,
	'charset' => undef,
	'generator' => undef,
	'tags' => $tags,
);
$css->put(
	['s', 'body'],
	['d', 'color', 'red'],
	['e'],
);
$obj->process;
$ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['r', '<!DOCTYPE html>'],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],

		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],

		['b', 'title'],
		['d', 'Page title'],
		['e', 'title'],

		['b', 'style'],
		['a', 'type', 'text/css'],
		['d', "body{color:red;}\n"],
		['e', 'style'],

		['e', 'head'],
		['b', 'body'],
	],
	'Begin of page without charset and generator and with CSS.',
);

# Test.

$obj = Tags::HTML::Page::Begin->new(
	'refresh' => 30,
	'tags' => $tags,
);
$obj->process;
$ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['r', '<!DOCTYPE html>'],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],

		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'charset', 'UTF-8'],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'name', 'generator'],
		['a', 'content', 'Perl module: Tags::HTML::Page::Begin, Version: '.
			$Tags::HTML::Page::Begin::VERSION],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'http-equiv', 'refresh'],
		['a', 'content', 30],
		['e', 'meta'],

		['b', 'title'],
		['d', 'Page title'],
		['e', 'title'],

		['e', 'head'],
		['b', 'body'],
	],
	'Begin of page in default with refresh.',
);

# Test.
$obj = Tags::HTML::Page::Begin->new(
	'base_href' => 'https://skim.cz',
	'tags' => $tags,
);
$obj->process;
$ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['r', '<!DOCTYPE html>'],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],

		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],

		['b', 'base'],
		['a', 'href', 'https://skim.cz'],
		['e', 'base'],

		['b', 'meta'],
		['a', 'charset', 'UTF-8'],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'name', 'generator'],
		['a', 'content', 'Perl module: Tags::HTML::Page::Begin, Version: '.
			$Tags::HTML::Page::Begin::VERSION],
		['e', 'meta'],

		['b', 'title'],
		['d', 'Page title'],
		['e', 'title'],

		['e', 'head'],
		['b', 'body'],
	],
	'Begin of page in default with base href.',
);

# Test.
$obj = Tags::HTML::Page::Begin->new(
	'base_href' => 'https://skim.cz',
	'base_target' => '_blank',
	'tags' => $tags,
);
$obj->process;
$ret_ar = $tags->flush(1);
is_deeply(
	$ret_ar,
	[
		['r', '<!DOCTYPE html>'],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],

		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],

		['b', 'base'],
		['a', 'href', 'https://skim.cz'],
		['a', 'target', '_blank'],
		['e', 'base'],

		['b', 'meta'],
		['a', 'charset', 'UTF-8'],
		['e', 'meta'],

		['b', 'meta'],
		['a', 'name', 'generator'],
		['a', 'content', 'Perl module: Tags::HTML::Page::Begin, Version: '.
			$Tags::HTML::Page::Begin::VERSION],
		['e', 'meta'],

		['b', 'title'],
		['d', 'Page title'],
		['e', 'title'],

		['e', 'head'],
		['b', 'body'],
	],
	'Begin of page in default with base href and target.',
);
