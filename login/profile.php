<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$sql=mysqli_query($con,"SELECT * FROM register where log_id=$log_id");
$list=array();
if($sql->num_rows>0 )
{
    while($row=mysqli_fetch_assoc($sql))
        {
          $myarray['result']='success';
          $myarray['log_id']=$row['log_id'];
    
        //   $myarray['dp']=$row['dp'];
          // $myarray['email']=$row['email'];


          array_push($list,$myarray);

         }
        }
else{
        $myarray['result']='failed';
        array_push($list,$myarray);
}
echo json_encode($myarray);
?>