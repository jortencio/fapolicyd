# @summary A type for defining a fapolicyd rule subject
type Fapolicyd::Subject = Struct[
  'type' => Enum['all','auid','uid','gid','sessionid','pid','ppid','trust','comm','exe','dir','ftype','device','pattern'],
  'setting' => Optional[Variant[String[1],Integer]],
]
