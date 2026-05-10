use std::io;
fn main() {
    println!("Calkulator in R*st");
    let mut option: String = String::new();
    let mut first_num: String = String::new();
    let mut second_num: String = String::new();
    println!("Select either mult, div or sum ");
    println!("Enter the option");
    io::stdin()
        .read_line(&mut option)
        .expect("Faild to read line.");
    println!("Enter da first number");
    io::stdin()
        .read_line(&mut first_num)
        .expect("Faild to read line.");

    println!("Enter da second number");
    io::stdin()
        .read_line(&mut second_num)
        .expect("Faild to read line.");

    let option: &str = option.trim();
    let first_num: f64 = first_num.trim().parse().expect("Failed to parse");
    let second_num: f64 = second_num.trim().parse().expect("Failed to parse");

    match option {
        "mult" => println!(
            "The result of the multiplication is {}",
            multiply(first_num, second_num)
        ),
        "div" => println!(
            "The result of the divition is {}",
            divide(first_num, second_num)
        ),
        "sum" => println!("The result of the sum is {}", sum(first_num, second_num)),
        _ => println!("Enter either mult or sum"),
    }
}
fn sum(a: f64, b: f64) -> f64 {
    a+b
}
fn multiply(a: f64, b: f64) -> f64 {
    a*b
}
fn divide(a: f64, b: f64) -> f64 {
    if b == 0.0 {
        0.0
    } else {
        a/b
    }
}
