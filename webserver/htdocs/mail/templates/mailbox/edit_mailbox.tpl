<div class="container">
	<div class="row">
		<div class="col-md-14">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Edit</h3>
				</div>
				<div class="panel-body">
<?php
if (!ctype_alnum(str_replace(array('.', '@'), '', $_GET["editmailbox"])) || empty($_GET["editmailbox"])) {
	echo 'Your provided mailbox name is invalid.';
}
else {
	$editmailbox = mysqli_real_escape_string($link, $_GET["editmailbox"]);
	if (mysqli_result(mysqli_query($link, "SELECT username, domain FROM mailbox WHERE username='$editmailbox' AND ((domain IN (SELECT domain from domain_admins WHERE username='$logged_in_as') OR 'admin'='$logged_in_role'))"))) {
	$result = mysqli_fetch_assoc(mysqli_query($link, "SELECT username, name, round(sum(quota / 1048576)) as quota, active FROM mailbox WHERE username='$editmailbox'"));
?>
				<h4>Change settings for mailbox <strong><?php echo $editmailbox ?></strong></h4>
				<form class="form-horizontal" role="form" method="post" action="/edit_mailbox">
				<input type="hidden" name="mailboxaction" value="editmailbox">
				<input type="hidden" name="username" value="<?php echo $result['username']; ?>">
					<div class="form-group">
						<label class="control-label col-sm-2" for="name">Name:</label>
						<div class="col-sm-10">
						<input type="text" class="form-control" name="name" id="name" value="<?php echo $result['name']; ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="quota">Quota (MB), 0 = unlimited:</label>
						<div class="col-sm-10">
						<input type="number" class="form-control" name="quota" id="quota" value="<?php echo $result['quota']; ?>">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="password">Password:</label>
						<div class="col-sm-10">
						<input type="password" class="form-control" name="password" id="password" placeholder="Leave empty to not change password">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="password2">Password (repeat):</label>
						<div class="col-sm-10">
						<input type="password" class="form-control" name="password2" id="password2">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<div class="checkbox">
							<label><input type="checkbox" name="active" <?php if (isset($result['active']) && $result['active']=="1") { echo "checked"; }; ?>> Active</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-success btn-sm">Submit</button>
						</div>
					</div>
<?php
	}
	else {
		echo 'Your provided mailbox does not exist.';
	}
}
?>
				</form>
				</div>
			</div>
		</div>
	</div>
<a href="#" onclick="window.history.back();return false;">&#8592; go back</a>
</div>