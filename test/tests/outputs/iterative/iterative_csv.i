[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
[]

[Variables]
  [./u]
  [../]
[]

[Kernels]
  [./diff]
    type = CoefDiffusion
    variable = u
    coef = 0.1
  [../]
  [./time]
    type = TimeDerivative
    variable = u
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = left
    value = 0
  [../]
  [./right]
    type = DirichletBC
    variable = u
    boundary = right
    value = 1
  [../]
[]

[Postprocessors]
  [./iterations]
     type = NumResidualEvaluations
     execute_on = linear
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  type = Transient
  num_steps = 20
  dt = 0.1
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  output_on = 'timestep_end'
  [./console]
    type = Console
    perf_log = true
    output_on = 'failed nonlinear linear timestep_end'
  [../]
  [./out]
    type = CSV
    nonlinear_residual_dt_divisor = 100
    linear_residual_dt_divisor = 100
    start_time = 1.8
    end_time = 1.85
    output_on = 'nonlinear linear timestep_end'
  [../]
[]
