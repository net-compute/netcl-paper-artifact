if [ -z "$NCLANG" ]; then
  export NCLANG="$HOME/nclang-0.1.0/build/bin/nclang"
fi

if [ -z "$P4C" ]; then
  export P4C="$HOME/bf-sde-9.13.0/install/bin/bf-p4c"
fi

set -e

totals=`date +%s`

echo "[+] Preparing programs..."
startt=`date +%s`
python3 compile_programs_and_gen_loc.py
endt=`date +%s`
echo "[+] took $((($endt - $startt) / 60))m$((($endt - $startt ) % 60))s"
echo

echo "[+] Generating Table 3..."
startt=`date +%s`
python3 generate_table_3.py | tee table_3.txt
endt=`date +%s`
echo "[+] took $((($endt - $startt) / 60))m$((($endt - $startt ) % 60))s"
echo

echo "[+] Generating Table 4..."
# startt=`date +%s`
# python3 -u generate_table_4.py --keep | tee table_4.txt
# endt=`date +%s`
# echo "[+] took $((($endt - $startt) / 60))m$((($endt - $startt ) % 60))s"
# echo

echo "[+] Generating Table 6..."
startt=`date +%s`
python3 generate_table_6.py | tee table_6.txt
endt=`date +%s`
echo "[+] took $((($endt - $startt) / 60))m$((($endt - $startt ) % 60))s"
echo

echo "[+] Generating Figure 12..."
startt=`date +%s`
python3 generate_figure_12.py
endt=`date +%s`
echo "[+] took $((($endt - $startt) / 60))m$((($endt - $startt ) % 60))s"
echo

totalf=`date +%s`
echo "Finished after $((($totalf - $totals) / 60))m$((( $totalf - $totals ) % 60))s"

