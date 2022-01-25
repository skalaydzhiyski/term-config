#!/usr/bin/python3
import os

plutus_dir = '/home/darchitect/work/ppp'
dirs = [
    f'{plutus_dir}/plutus-apps/plutus-contract/',
    f'{plutus}/plutus-apps/plutus-ledger/',
    f'{plutus}/plutus-apps/plutus-ledger-constraints/',
    f'{plutus}/plutus-apps/plutus-use-cases/',
    f'{plutus}/plutus/plutus-core/',
    f'{plutus}/plutus/plutus-ledger-api/',
    f'{plutus}/plutus/plutus-tx/',
    f'{plutus}/plutus/plutus-tx-plugin/',
    f'{plugin}/plutus/plutus-errors/'
]
for d in dirs:
  print(f'going through {d}...')
  os.system(f'hasktags {d} -a')
  print('done.')
  os.remove('TAGS')


