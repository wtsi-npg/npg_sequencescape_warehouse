#!/bin/bash

set -e -x

WTSI_NPG_BUILD_BRANCH=${WTSI_NPG_BUILD_BRANCH:=devel}
WTSI_NPG_GITHUB_URL=${WTSI_NPG_GITHUB_URL:=https://github.com/wtsi-npg}

# CPAN
cpanm --quiet --notest Alien::Tidyp # For npg_tracking
cpanm --quiet --notest Module::Build
cpanm --quiet --notest https://github.com/chapmanb/vcftools-cpan/archive/v0.953.tar.gz # for npg_qc

# WTSI NPG Perl repo dependencies
repos=""
for repo in perl-dnap-utilities npg_tracking; do
    cd /tmp
    # Always clone master when using depth 1 to get current tag
    git clone --branch master --depth 1 "${WTSI_NPG_GITHUB_URL}/${repo}.git" ${repo}.git
    cd /tmp/${repo}.git
    # Shift off master to appropriate branch (if possible)
    git ls-remote --heads --exit-code origin "${WTSI_NPG_BUILD_BRANCH}" && git pull origin "${WTSI_NPG_BUILD_BRANCH}" && echo "Switched to branch ${WTSI_NPG_BUILD_BRANCH}"
    repos=$repos" /tmp/${repo}.git"
done

# Install CPAN dependencies. The src libs are on PERL5LIB because of
# circular dependencies. The blibs are on PERL5LIB because the package
# version, which cpanm requires, is inserted at build time. They must
# be before the libs for cpanm to pick them up in preference.

for repo in $repos
do
    export PERL5LIB=$repo/blib/lib:$PERL5LIB:$repo/lib
done

for repo in $repos
do
    cd "$repo"
    cpanm --quiet --notest --installdeps .
    perl Build.PL
    ./Build
done

# Finally, bring any common dependencies up to the latest version and
# install
for repo in $repos
do
    cd "$repo"
    cpanm --quiet --notest --installdeps .
    ./Build install
done
