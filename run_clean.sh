set -e

python3 compile_programs_and_gen_loc.py --cleanup

python3 generate_table_4.py --cleanup

rm -f table_3.txt table_4.txt table_6.txt figure_12.pdf