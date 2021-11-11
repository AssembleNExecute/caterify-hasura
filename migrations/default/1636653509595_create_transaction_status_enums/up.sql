CREATE TYPE transaction_status AS ENUM ('PAYMENT_INITIATED', 'PAYMENT_IN_PROGRESS', 'PAYMENT_SUCCESSFUL', 'PAYMENT_FAILED', 'PAYMENT_TIMED_OUT');