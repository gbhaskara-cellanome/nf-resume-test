nextflow.enable.dsl=2

params.start_num = 1
params.out_dir = 'results'

process step1 {
  input:
    val n
  output:
    path "step1.txt"
  script:
    """
    echo $n > step1.txt
    """
}

process step2 {
  input:
    path in_file
  output:
    path "step2.txt"
  script:
    """
    prev=\$(tail -1 $in_file)
    result=\$((prev + 1))
    cat $in_file > step2.txt
    echo \$result >> step2.txt
    """
}

process step3 {
  input:
    path in_file
  output:
    path "step3.txt"
  script:
    """
    prev=\$(tail -1 $in_file)
    result=\$((prev + 1))
    cat $in_file > step3.txt
    echo \$result >> step3.txt
    exit 1
    """
}

process step4 {
  input:
    path in_file
  output:
    path "final.txt"
  publishDir params.out_dir, mode: 'copy'
  script:
    """
    prev=\$(tail -1 $in_file)
    result=\$((prev + 1))
    cat $in_file > final.txt
    echo \$result >> final.txt
    """
}

workflow {
  Channel
    .value(params.start_num)
    | step1
    | step2
    | step3
    | step4

  final_txt = step4.out
  final_txt.view { "Final file created: $it" }
}
