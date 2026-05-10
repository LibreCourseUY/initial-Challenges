use rand::RngExt;
use std::cmp::Ordering;
use std::io;
fn main() {
    let secret_number = rand::rng().random_range(0..=100);
    println!("Secret Number {secret_number}");
    println!("Guess the number from 0-100: ");
    let mut guess = String::new();
    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
    let guess: u32 = guess.trim().parse().expect("Input a number");
    println!("My Guess {guess}");
    match guess.cmp(&secret_number) {
        Ordering::Less => println!("Too Small!"),
        Ordering::Greater => println!("Too big!"),
        Ordering::Equal => println!("Win ez!"),
    }
}
