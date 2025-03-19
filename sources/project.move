module MyModule::FinanceTracker {
    use aptos_framework::signer;

    /// Struct to store user's total expenses
    struct Expense has key, store {
        total_spent: u64,
    }

    /// Function to create an expense record or add to an existing one
    public entry fun add_expense(user: &signer, amount: u64) acquires Expense {
        let account = signer::address_of(user);

        if (!exists<Expense>(account)) {
            move_to(user, Expense { total_spent: amount });
        } else {
            let expense = borrow_global_mut<Expense>(account);
            expense.total_spent = expense.total_spent + amount;
        }
    }

    /// Function to check total expenses of a user
    public fun get_total_expenses(user: address): u64 acquires Expense {
        if (exists<Expense>(user)) {
            borrow_global<Expense>(user).total_spent
        } else {
            0
        }
    }
}
