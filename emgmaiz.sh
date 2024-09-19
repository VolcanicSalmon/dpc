fw=($(ls *1.trim.fq | sed -n ${SLURM_ARRAY_TASK_ID}p))
rv=$(echo $fw | sed 's/_1.trim.fq/_2.trim.fq/')
pref=$(echo $fw | sed 's/_1.trim.fq//')
../Python*/python ../EMIRGE/emirge_amplicon.py /mnt/shared/projects/rbgk/users_area/kli/maize/${pref}/ -1 $fw -2 $rv -i 230 -s 85 -f ../silvals_dedup.fa -b ../silva_ls_btindex -l 150 -a12 --phred33
