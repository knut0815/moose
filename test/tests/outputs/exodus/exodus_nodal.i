##
# \file exodus/exodus_nodal.i
# \example exodus/exodus_nodal.i
# Input file for testing nodal data output
#
[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
[]

[Variables]
  [./u]
  [../]
  [./v]
  [../]
[]

[AuxVariables]
  [./aux0]
    order = SECOND
    family = SCALAR
  [../]
  [./aux1]
    family = SCALAR
    initial_condition = 5
  [../]
  [./aux2]
    family = SCALAR
    initial_condition = 10
  [../]
  [./aux3]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[Kernels]
  [./diff_u]
    type = Diffusion
    variable = u
  [../]
  [./diff_v]
    type = CoefDiffusion
    variable = v
    coef = 2
  [../]
[]

[BCs]
  [./right_u]
    type = DirichletBC
    variable = u
    boundary = right
    value = 1
  [../]
  [./left_u]
    type = DirichletBC
    variable = u
    boundary = left
    value = 0
  [../]
  [./right_v]
    type = DirichletBC
    variable = v
    boundary = right
    value = 3
  [../]
  [./left_v]
    type = DirichletBC
    variable = v
    boundary = left
    value = 2
  [../]
[]

[Postprocessors]
  [./num_vars]
    type = NumVars
  [../]
  [./num_aux]
    type = NumVars
    system = auxiliary
  [../]
[]

[Executioner]
  type = Steady
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

##! [MultipleOutputBlocks]
[Outputs]
  output_on = 'timestep_end'
  [./out]
    type = Exodus
    hide = 'u v aux0 aux1'
    scalar_as_nodal = true
    elemental_as_nodal = true
    output_elemental_on = none
    output_scalars_on = none
    output_postprocessors_on = none
  [../]
  [./screen]
    type = Console
    perf_log = true
    output_on = 'failed nonlinear timestep_end'
  [../]
[]
##! [MultipleOutputBlocks]

[ICs]
  [./aux0_IC]
    variable = aux0
    values = '12 13'
    type = ScalarComponentIC
  [../]
[]
