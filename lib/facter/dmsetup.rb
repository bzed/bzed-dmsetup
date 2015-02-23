# Fact: dmsetup
#
# Purpose: Return dmsetup info/ls/deps output
#
# Caveats: Works on Linux only.
#

if Facter::Core::Execution.which('dmsetup')
    ls = Facter::Core::Execution.execute('dmsetup ls -o blkdevname')
    dmsetup_ls=ls.scan(/^(.*)\t+\((.*)\)$/)
    dmsetup = Hash[dmsetup_ls.map { |key, value| [ key, Hash["blkdevname", value] ] } ]

    info = Facter::Core::Execution.execute('dmsetup info \
                                            --noheadings \
                                            --separator ";" \
                                            -c  \
                                            -o name,major,minor,attr,open,segments,events,uuid'
                                          )
    dmsetup_info=info.scan(/^([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);([0-9A-Za-z-]+)/)
    dmsetup = dmsetup.merge(Hash[
        dmsetup_info.map {
            |name,major,minor,attr,open,segments,events,uuid|
            [ name,
              Hash['major', major,
                   'minor', minor,
                   'attr', attr,
                   'open', open,
                   'segments', segments,
                   'events', events,
                   'uuid', uuid
                  ]
            ]
        }
    ]){ | key, oldval, newval | oldval.merge(newval) }

    deps = Facter::Core::Execution.execute('dmsetup deps -o devname')
    dmsetup_deps = deps.scan(/^([^:]+):\s[0-9]+\s*dependencies\s*:\s*(\(.*\))$/)
    dmsetup = dmsetup.merge(Hash[
        dmsetup_deps.map {
            |name, dependencies|
            [ name,
              Hash['dependencies',
                   dependencies.scan(/\(([^)]+)\)/).flatten()
                ]
            ]
        }
    ]){ | key, oldval, newval | oldval.merge(newval) }
else
    dmsetup = nil
end

Facter.add(:dmsetup) do
    setcode do
        dmsetup
    end
end

