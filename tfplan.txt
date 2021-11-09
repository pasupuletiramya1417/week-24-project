#
tfplan
├── module() (function)
│   └── (module namespace)
│       ├── path ([]string)
│       ├── data
│       │   └── TYPE.NAME[NUMBER]
│       │       ├── applied (map of keys)
│       │       └── diff
│       │           └── KEY
│       │               ├── computed (bool)
│       │               ├── new (string)
│       │               └── old (string)
│       └── resources
│           └── TYPE.NAME[NUMBER]
│               ├── applied (map of keys)
│               ├── destroy (bool)
│               ├── requires_new (bool)
│               └── diff
│                   └── KEY
│                       ├── computed (bool)
│                       ├── new (string)
│                       └── old (string)
├── module_paths ([][]string)
├── terraform_version (string)
├── variables (map of keys)
│
├── data (root module alias)
├── path (root module alias)
├── resources (root module alias)
│
├── config (tfconfig namespace alias)
└── state (tfstate import alias)
