fn main() {
	let args = std::env::args().skip(1).collect::<Vec<_>>();

	if args.is_empty() {
		eprintln!("Error: No command entered.\nUsage: revpath command arguments");
		return;
	}

	let path_var = std::env::var("PATH").expect("PATH variable is not set");
	let mut segments = path_var.split(':').collect::<Vec<_>>();
	segments.reverse();
	let new_path = segments.join(":");
	std::env::set_var("PATH", new_path);

	let program = &args[0];
	let args = &args[1..];

	std::process::Command::new(program)
		.args(args)
		.spawn()
		.unwrap();
}
