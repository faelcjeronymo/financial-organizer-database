-- Create TransactionCategory table first since other tables reference it
CREATE TABLE TransactionCategory (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(7) NOT NULL, -- Stores hexadecimal color values (e.g., #FF0000)
    transaction_type SMALLINT NOT NULL CHECK (transaction_type IN (1, 2)) -- 1 for Expenses, 2 for Revenues
);

-- Create Expenses table
CREATE TABLE Expenses (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    value NUMERIC(10, 2) NOT NULL, -- Suitable for monetary values
    payment_type SMALLINT NOT NULL CHECK (payment_type IN (1, 2)), -- 1 for Debit, 2 for Credit
    payed BOOLEAN NOT NULL DEFAULT FALSE,
    parcel_number INTEGER,
    aditional_info TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP WITH TIME ZONE,
    category_id INTEGER REFERENCES TransactionCategory(id),
    fixed_expense BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create Revenues table
CREATE TABLE Revenues (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    value NUMERIC(10, 2) NOT NULL, -- Suitable for monetary values
    received BOOLEAN NOT NULL DEFAULT FALSE,
    aditional_info TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    category_id INTEGER REFERENCES TransactionCategory(id)
);

-- Add comments to explain the tables and columns
COMMENT ON TABLE Expenses IS 'Stores information about financial expenses';
COMMENT ON COLUMN Expenses.payment_type IS '1 for Debit, 2 for Credit';
COMMENT ON COLUMN Expenses.category_id IS 'References TransactionCategory.id';

COMMENT ON TABLE Revenues IS 'Stores information about financial revenues';
COMMENT ON COLUMN Revenues.category_id IS 'References TransactionCategory.id';

COMMENT ON TABLE TransactionCategory IS 'Categories for both expenses and revenues';
COMMENT ON COLUMN TransactionCategory.transaction_type IS '1 for Expenses, 2 for Revenues';