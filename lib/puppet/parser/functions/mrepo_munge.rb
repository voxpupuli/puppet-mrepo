Puppet::Parser::Functions.newfunction(:mrepo_munge, :type => :rvalue, :doc => <<-EOS
Processes mrepo::repo names and collapses them to mach mrepo standards.
EOS
) do |arguments|
  raise Puppet::ParseError, "mrepo_munge(): Wrong number of arguments given (#{arguments.length} for 2)" unless arguments.length == 2

  reponame     = arguments[0]
  architecture = arguments[1]

  raise Puppet::ParseError, "mrepo_munge() takes (String, String), received (#{reponame.class}, #{architecture.class})" unless(reponame.is_a? String and architecture.is_a? String)

  collapsible_arches = %w{alpha i386 ia64 ppc ppc64 x86_64 sparc64 sparc64v s390 s390x}

  if collapsible_arches.include? architecture and reponame.match %r{^.*-#{architecture}$}
    reponame
  else
    "#{reponame}-#{architecture}"
  end
end
