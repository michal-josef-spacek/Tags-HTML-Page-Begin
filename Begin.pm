package Tags::HTML::Page::Begin;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Readonly;

# Constants.
Readonly::Hash my %LANG => (
	'title' => 'Page title',
);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# 'CSS::Struct' object.
	$self->{'css'} = undef;

	# Doctype.
	$self->{'doctype'} = '<!DOCTYPE html>';

	# Languages.
	$self->{'lang'} = \%LANG;

	# 'Tags' object.
	$self->{'tags'} = undef;

	# Process params.
	set_params($self, @params);

	# Check to 'Tags' object.
	if (! $self->{'tags'} || ! $self->{'tags'}->isa('Tags::Output')) {
		err "Parameter 'tags' must be a 'Tags::Output::*' class.";
	}

	# Check to 'CSS::Struct' object.
	if (! $self->{'css'} || ! $self->{'css'}->isa('CSS::Struct::Output')) {
		err "Parameter 'css' must be a 'CSS::Struct::Output::*' class.";
	}

	# Object.
	return $self;
}

# Process 'Tags'.
sub process {
	my $self = shift;

	my $css = $self->{'css'}->flush."\n";

	# Begin of page.
	$self->{'tags'}->put(
		['r', $self->{'doctype'}],
		['r', "\n"],
		['b', 'html'],
		['b', 'head'],
		['b', 'meta'],
		['a', 'http-equiv', 'Content-Type'],
		['a', 'content', 'text/html; charset=UTF-8'],
		['e', 'meta'],
		# XXX Refresh?
		['b', 'title'],
		['d', $self->{'lang'}->{'title'}],
		['e', 'title'],
		(
			$css ? (
				['b', 'style'],
				['a', 'type', 'text/css'],
				['d', $css],
				['e', 'style'],
			) : (),
		),
		['e', 'head'],
		['b', 'body'],
	);

	return;
}

sub process_css {
	my $self = shift;

	# Create styles.
	$self->{'css'}->put(
		['s', '.okay'],
		['d', 'background', '#9f9'],
		['e'],
		['s', '.warning'],
		['d', 'background', '#ff9'],
		['e'],
		['s', '.alert'],
		['d', 'background', '#f99'],
		['e'],
		['s', '.offline'],
		['d', 'color', '#999'],
		['e'],
	);

	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tags::HTML::Page::Begin - Tags helper for HTML page begin.

=head1 SYNOPSIS

 use Tags::HTML::Page::Begin;

 my $obj = Tags::HTML::Page::Begin->new(%params);
 $obj->process;
 $obj->process_css;

=head1 METHODS

=head2 C<new>

 my $obj = Tags::HTML::Stars->new(%params);

Constructor.

=over 8

=item * C<doctype>

Document doctype string.

Default value is '<!DOCTYPE html>'.

=item * C<css>

'CSS::Struct::Output' object for L<process_css> processing.

It's required.

Default value is undef.

=item * C<lang>

Hash with language information for output.
Keys are: 'title'.

Default value is reference to hash with these value:
 'title' => 'Page title'

=item * C<tags>

'Tags::Output' object.

It's required.

Default value is undef.

=back

=head2 C<process>

 $obj->process;

Process Tags structure for output.

Returns undef.

=head2 C<process_css>

 $obj->process_css;

Process CSS::Struct structure for output.
This processing must be before L<process>, because in L<process> is output used.

Returns undef.

=head1 ERRORS

 new():
         From Class::Utils::set_params():
                 Unknown parameter '%s'.

=head1 EXAMPLE1

 use strict;
 use warnings;

 use CSS::Struct::Output::Indent;
 use Tags::HTML::Page::Begin;
 use Tags::HTML::Page::End;
 use Tags::Output::Indent;

 # Object.
 my $tags = Tags::Output::Indent->new(
         'preserved' => ['style'],
 );
 my $css = CSS::Struct::Output::Indent->new;
 my $begin = Tags::HTML::Page::Begin->new(
         'css' => $css,
         'tags' => $tags,
 );
 my $end = Tags::HTML::Page::End->new(
         'tags' => $tags,
 );

 # Process page
 $begin->process_css;
 $begin->process;
 $tags->put(
        ['b', 'div'],
        ['d', 'Hello world!'],
        ['e', 'div'],
 );
 $end->process;

 # Print out.
 print $tags->flush;

 # Output:
 # <!DOCTYPE html>
 # <html>
 #   <head>
 #     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 #     </meta>
 #     <title>
 #       Page title
 #     </title>
 #     <style type="text/css">
 # .okay {
 # 	background: #9f9;
 # }
 # .warning {
 # 	background: #ff9;
 # }
 # .alert {
 # 	background: #f99;
 # }
 # .offline {
 # 	color: #999;
 # }
 # </style>
 #   </head>
 #   <body>
 #     <div>
 #       Hello world!
 #     </div>
 #   </body>
 # </html>

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<List::Utils>,
L<MIME::Base64>,
L<Readonly>.

=head1 SEE ALSO

=over

=item L<Tags::HTML::Page::End>

Tags helper for HTML page end.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Tags-HTML-Page-Begin>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© Michal Josef Špaček 2020

BSD 2-Clause License

=head1 VERSION

0.01

=cut
