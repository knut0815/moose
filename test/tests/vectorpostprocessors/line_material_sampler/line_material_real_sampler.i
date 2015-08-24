[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 1
  ymin = 0
  ymax = 1
  nx = 4
  ny = 4
[]

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./mat]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./diff]
    type = MatDiffusion
    variable = u
    prop_name = matp
  [../]
[]

[AuxKernels]
  [./mat]
    type = MaterialRealAux
    variable = mat
    property = matp
    execute_on = timestep_end
  [../]
[]

[VectorPostprocessors]
  [./mat]
    type = LineMaterialRealSampler
    start = '0.125 0.375 0.0'
    end   = '0.875 0.375 0.0'
    property = matp
    sort_by = id
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = 3
    value = 1
  [../]

  [./right]
    type = MTBC
    variable = u
    boundary = 1
    grad = 8
    prop_name = matp
  [../]
[]

[Materials]
  [./mat]
    type = MTMaterial
    block = 0
  [../]
[]

[Executioner]
  type = Steady

  # Preconditioned JFNK (default)
  solve_type = 'PJFNK'
[]

[Outputs]
  output_on = 'timestep_end'
  file_base = out
  output_on = 'initial timestep_end'
  csv = true
  [./exodus]
    type = Exodus
    elemental_as_nodal = true
  [../]
  [./console]
    type = Console
    perf_log = true
    output_on = 'timestep_end failed nonlinear'
  [../]
[]
