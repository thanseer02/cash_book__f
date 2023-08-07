<?php
include '../connect.php';
$name=$_POST['name'];
$mobile_no=$_POST['mobile_no'];
$password=$_POST['password'];
$sql1=mysqli_query($con,"INSERT into login (mobile_no,password) values('$mobile_no','$password')");
$user_id=mysqli_insert_id(($con));
$sql2=mysqli_query($con,"INSERT into register(name,log_id)values('$name','$user_id')");
if ($sql1 && $sql2) {
    $myarray['result']='success';
}
else{
    $myarray['result']='failed';
}
echo json_encode($myarray);
?>