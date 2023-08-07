<?php
include '../connect.php';
$mobile_no=$_POST['mobile_no'];
$password=$_POST['password'];
$sql="";
$sql=mysqli_query($con,"SELECT * FROM login where mobile_no='$mobile_no' and password='$password'");
if ($sql->num_rows>0) {
    while ($row=mysqli_fetch_assoc($sql)) {

        $myarray['result']='success';
        $myarray['log_id']=$row['log_id'];

    }
}
else {
    $myarray['result']='failed';
}
echo json_encode($myarray);
?>