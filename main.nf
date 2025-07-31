nextflow.enable.dsl=2

// Start value for the chain
params.start_num = 1

// Process 1: Increment number and pass to step 2
process step1 {
  input:
    val n
  output:
    val(result)
  script:
    result = n + 1
    """
    echo $result
    """
}

// Process 2: Increment again and pass on
process step2 {
  input:
    val n
  output:
    val(result)
  script:
    result = n + 1
    """
    echo $result
    """
}

// Process 3: Increment again
process step3 {
  input:
    val n
  output:
    val(result)
  script:
    result = n + 1
    """
    echo $result
    """
}

// Process 4: Final increment and print output
process step4 {
  input:
    val n
  output:
    stdout
  script:
    result = n + 1
    """
    echo $result
    """
}

workflow {
  Channel
    .value(params.start_num)
    | step1
    | step2
    | step3
    | step4
    | view
}
