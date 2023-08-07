<?php
include '../connect.php';
$log_id=$_POST['log_id'];
$amount=$_POST['amount'];
$discription=$_POST['discription'];
$status=$_POST['status'];
$date=$_POST['date'];
$sql=mysqli_query($con,"INSERT into inc_exp(log_id,amount,discription,status,date) values ('$log_id','$amount','$discription','$status','$date')");
if ($sql) {
$myarray['result']='success';
}
else
{
    $myarray['result']='failed';
}
echo json_encode($myarray);
?>