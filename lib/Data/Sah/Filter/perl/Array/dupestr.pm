package Data::Sah::Filter::perl::Array::dupestr;

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
        summary => 'Return the elements of array that appear more than once',
        args => {
            uniq => {
                summary => 'If set to true, will only list each duplicate once',
                schema => 'bool*',
            },
        },
        examples => [
            {value=>[], filtered_value=>[]},
            {value=>["a","b"], filtered_value=>[]},
            {value=>["a","b","a","a","c","b"], filtered_value=>["a","a","b"]},
            {value=>["a","b","a","a","c","b"], filter_args=>{uniq=>1}, filtered_value=>["a","b"]},
        ],
    };
}

sub filter {
    my %fargs = @_;

    my $dt = $fargs{data_term};
    my $gen_args = $fargs{args} // {};

    my $res = {};
    $res->{modules}{'List::Util'} = 1.54;
    $res->{modules}{'List::Util::Uniq'} = 1.54;
    $res->{expr_filter} = join(
        "",
        ($gen_args->{uniq} ? "[List::Util::uniqstr(List::Util::Uniq::dupestr(\@{ $dt }))]" : "[List::Util::Uniq::dupestr(\@{ $dt })]"),
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 SEE ALSO

L<Data::Sah::Filter::perl::Array::dupenum>.
