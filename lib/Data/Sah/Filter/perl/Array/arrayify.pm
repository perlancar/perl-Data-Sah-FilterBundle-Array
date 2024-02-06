package Data::Sah::Filter::perl::Array::arrayify;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Wrap non-array X to become [X]',
        args => {
        },
        examples => [
            {value=>[], filtered_value=>[]},
            {value=>[1,[]], filtered_value=>[1,[]]},
            {value=>"foo", filtered_value=>["foo"]},
            {value=>[{}], filtered_value=>[{}]},
        ],
    };
}

sub filter {
    my %fargs = @_;

    my $dt = $fargs{data_term};
    #my $gen_args = $fargs{args} // {};

    my $res = {};
    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; ref \$tmp eq 'ARRAY' ? \$tmp : [\$tmp] }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 SEE ALSO
