package App::CSV2Table;
use strict;
use warnings;
use utf8;
use Carp;
use Data::Table;
use Text::UnicodeTable::Simple;

our $VERSION = "0.01";

binmode STDOUT, ':utf8';

sub run {
  my $self = shift;
  my @args = @_;
  my ( $data, $table );

  if ( $args[0] ) {
    if ( !-e $args[0] ) {
      print "cannot find file: $args[0]", "\n";
      exit;
    }
    $data = Data::Table::fromCSV( $args[0], 1 );
  } else {
    $data = Data::Table::fromCSV(\*STDIN, 1);
  }

  $table = Text::UnicodeTable::Simple->new();
  $table->set_header($data->header);
  my $it = $data->iterator();
  while(my $row = $it->()){
    my @row = @$row{ $data->header };
    $table->add_row(@row);
  }
  print $table;
}

1;
__END__

=encoding utf-8

=head1 NAME

App::CSV2Table - It's new $module

=head1 SYNOPSIS

    use App::CSV2Table;

=head1 DESCRIPTION

App::CSV2Table is ...

=head1 LICENSE

Copyright (C) trapple

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

masuda E<lt>trapplejp@gmail.comE<gt>

=cut

