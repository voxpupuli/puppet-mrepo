# RedHat Mirroring #

## RedHat Network account information ##

To automatically generate RedHat repositories, you will need to supply your RHN
credentials in the puppet manifests, regrettably in plaintext. This is needed
to generate the systemid information. You may want to keep your manifests
secured, or alternately generate the systemid on the command line after the
fact. If you specify the rhn parameter to mrepo::repo as false, it will not
attempt to generate a systemid and you can do that interactively with
gensystemid after the mrepo module has been applied.

For CentOS servers with the rhn parameter set as true, RHN dependencies
will be configured by default. For RHEL servers, also specify the
rhn_config parameter as true in order to configure the RHN dependencies.

## systemid and entitlements ##

RHEL mirroring operates by emulating a specific RedHat release and
architecture, which will require at least one entitlement. You can also mirror
additional channels, but be warned that they may require additional
entitlements.

### the typerelease parameter ###

Unfortunately there is no regular pattern for release names and available
architectures.  Validation for this would get prohibitively costly, and has
been left as the responsibility of the user. In addition, there is a common
convention to mainly differentiate between releases on the major version
number. The type and typerelease fields were added to mrepo::repo to deal with this
complexity. 

For RHN, $type must be 'rhn', $release is generally similar to '5.6' or '6',
and $typerelease and $arch must match the following values in order for 
a valid systemid to be generated.
This list was pulled from the gensystemid command, from mrepo release 8138e3bb6b5aa26cf8db.

  * '6Workstation': 'i386', 'x86_64'
  * '6Server': 'i386', 'ppc', 's390', 's390x', 'x86_64'
  * '6ComputeNode': 'i386', 'ppc', 's390', 's390x', 'x86_64'
  * '6Client': 'i386', 'x86_64'
  * '5Server': 'i386', 'ia64', 'ppc', 's390', 's390x', 'x86_64'
  * '5Client': 'i386', 'ia64', 'x86_64'
  * '4AS': 'i386', 'ia64', 'ppc', 's390', 's390x', 'x86_64'
  * '4ES': 'i386', 'ia64', 'x86_64'
  * '4WS': 'i386', 'ia64', 'x86_64'
  * '4Desktop': 'i386', 'x86_64'
  * '3AS': 'i386', 'ia64', 'ppc', 's390', 's390x', 'x86_64'
  * '3ES': 'i386', 'ia64', 'x86_64'
  * '3WS': 'i386', 'ia64', 'x86_64'
  * '3Desktop': 'i386', 'x86_64'
  * '2.1AS': 'i386', 'ia64'
  * '2.1ES': 'i386'
  * '2.1WS': 'i386'
  * '2.1AW': 'ia64'
