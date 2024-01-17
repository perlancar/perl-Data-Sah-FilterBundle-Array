package Data::Sah::Filter::perl::Array::dupenum;

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
            {value=>[1,2], filtered_value=>[]},
            {value=>[1,2,1,1,3,2], filtered_value=>[1,1,2]},
            {value=>[1,2,1,1,3,2], filter_args=>{uniq=>1}, filtered_value=>[1,2]},
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
        ($gen_args->{uniq} ? "[List::Util::uniqnum(List::Util::Uniq::dupenum(\@{ $dt }))]" : "[List::Util::Uniq::dupenum(\@{ $dt })]"),
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 SEE ALSO

L<Data::Sah::Filter::perl::Array::dupestr>.
