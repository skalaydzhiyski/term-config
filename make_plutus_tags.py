#!/usr/bin/python3
import os

plutus_dir = os.environ['HOME']
dirs = [
    f'{plutus_dir}/plutus-apps/plutus-contract/',
    f'{plutus_dir}/plutus-apps/plutus-ledger/',
    f'{plutus_dir}/plutus-apps/plutus-ledger-constraints/',
    f'{plutus_dir}/plutus-apps/plutus-use-cases/',
    f'{plutus_dir}/plutus/plutus-core/',
    f'{plutus_dir}/plutus/plutus-ledger-api/',
    f'{plutus_dir}/plutus/plutus-tx/',
    f'{plutus_dir}/plutus/plutus-tx-plugin/',
    f'{plutus_dir}/plutus/plutus-errors/'
]
for d in dirs:
  print(f'going through {d}...')
  os.system(f'hasktags -c -R {d} -a')
  print('done.')


