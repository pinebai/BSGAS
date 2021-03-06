module unstr_output
implicit none
integer :: output_intervall
contains
subroutine write_output(iter)
   use types
   use unstr, only: git
   use spring, only: springs
implicit none

integer, intent(in) :: iter
integer :: i
character(len=20) :: filename

if (mod(iter,output_intervall) == 0) then
   write(filename,'(a,i0,a)') "paraview_",iter,".vtk"
   open(10,file=filename)

   write(10,"(a)") '# vtk DataFile Version 2.0'
   write(10,"(a)") 'GRID-ADAPTION unstructured_grid'
   write(10,"(a)") 'ASCII'
   write(10,"(a)") ""
   write(10,"(a)") "DATASET UNSTRUCTURED_GRID"
   write(10,"(a,1X,i0,1X,a)") "POINTS",git % nPoint,"float"
   do i = 1, git % nPoint
      write(10,'(3(f20.13,1X))') git % point_coords(:,i)
   end do
   write(10,*)
   write(10,"(a,1X,i0,1X,i0)") "CELLS", git % nedge, git % nedge*3
   do i = 1, git % nedge
      write(10,'(3(i0,1X))') 2,git % edge_points(1,i)-1,git % edge_points(2,i)-1
   end do
   write(10,*)
   write(10,"(a,1X,i0)") "CELL_TYPES", git % nedge
   do i = 1, git % nedge
      write(10,'(i0)') 3
   end do
   write(10,*)
   write(10,"(A,1X,I0)") "POINT_DATA",git % nPoint
   write(10,"(A)") 'VECTORS Point_FORCE float'
   do i = 1, git % nPoint
      write(10,'(3(f20.13,1X))') git % point_forces(:,i)
   end do
   write(10,"(A)") 'SCALARS MOVEMENT float'
   write(10,"(A)") 'LOOKUP_TABLE Default'
   do i = 1, git % nPoint
      write(10,*) git % point_move_rest_type(i)
   end do
   write(10,"(A)") 'VECTORS MOVEMENT_VECTOR float'
   do i = 1, git % nPoint
      write(10,'(3(f20.13,1X))') git % point_move_rest_vector(:,i)
   end do
   write(10,"(A,1X,I0)") "CELL_DATA",git % nedge
   write(10,"(A)") 'SCALARS Kantenlaenge double'
   write(10,"(A)") 'LOOKUP_TABLE Default'
   do i = 1, git % nedge
      write(10,*) git % edge_lengths(i)
   end do
   write(10,"(A)") 'SCALARS Wall_Spring double'
   write(10,"(A)") 'LOOKUP_TABLE Default'
   do i = 1, git % nedge
      write(10,*) springs(1,i)
   end do
   write(10,"(A)") 'SCALARS KantenSteifigkeit double'
   write(10,"(A)") 'LOOKUP_TABLE Default'
   do i = 1, git % nedge
      write(10,*) git % edge_springs(i)
   end do
   write(10,"(A)") 'SCALARS KantenForce double'
   write(10,"(A)") 'LOOKUP_TABLE Default'
   do i = 1, git % nedge
      write(10,*) sqrt(git % edge_forces(1,i)*git % edge_forces(1,i) &
                      +git % edge_forces(2,i)*git % edge_forces(2,i) &
                      +git % edge_forces(3,i)*git % edge_forces(3,i) )
   end do
   close(10)
end if
end subroutine write_output
end module unstr_output
