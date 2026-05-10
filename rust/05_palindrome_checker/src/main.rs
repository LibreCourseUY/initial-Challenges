use std::io;
fn main() {
    println!("Enter a word");
    let mut sample_text: String = String::new();
    io::stdin()
        .read_line(&mut sample_text)
        .expect("Failed to read");
    let sample_text: &str = sample_text.trim();
    let text_palindrome: &str = if is_palindrome(&sample_text) {
        "yes"
    } else {
        "no"
    };
    println!("{sample_text} is a palindrome? {text_palindrome}");

    println!("Press enter to exit");
    let mut exit_val: String = String::new();
    io::stdin()
        .read_line(&mut exit_val)
        .expect("Failed to read");
}
fn is_palindrome(text: &str) -> bool {
    let word_size: usize = text.chars().count();
    for i in 0..(1 + (word_size / 2)) {
        if text.chars().nth(i) != text.chars().nth(word_size - 1 - i) {
            return false;
        }
    }
    return true;
}