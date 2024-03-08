type Fapolicyd::Object = Struct[
  'type' => Enum['all','path','dir','device','ftype','trust','sha256hash'],
  'setting' => Optional[String[1]],
]
