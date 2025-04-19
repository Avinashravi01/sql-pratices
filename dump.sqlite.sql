PRAGMA foreign_keys = ON;

-- 1. user
CREATE TABLE user (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT UNIQUE,
    password TEXT,
    phone TEXT,
    membership_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. seat
CREATE TABLE seat (
    seat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    seat_number TEXT,
    seat_type TEXT,
    is_available INTEGER DEFAULT 1
);

-- 3. screen
CREATE TABLE screen (
    screen_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    total_seats INTEGER
);

-- 4. movie
CREATE TABLE movie (
    movie_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    genre TEXT,
    duration INTEGER,
    language TEXT,
    release_date DATE,
    is_available INTEGER DEFAULT 1
);

-- 5. fooditem
CREATE TABLE fooditem (
    fooditem_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    is_combo INTEGER DEFAULT 0,
    is_available INTEGER DEFAULT 1
);

-- 6. paymentgateway
CREATE TABLE paymentgateway (
    gateway_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    status INTEGER DEFAULT 1
);

-- 7. membership
CREATE TABLE membership (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    discount_percentage REAL,
    validity_days INTEGER
);

-- 8. showtable
CREATE TABLE showtable (
    show_id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER,
    screen_id INTEGER,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (screen_id) REFERENCES screen(screen_id)
);

-- 9. fooditemsize
CREATE TABLE fooditemsize (
    size_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fooditem_id INTEGER,
    size_name TEXT,
    price REAL,
    FOREIGN KEY (fooditem_id) REFERENCES fooditem(fooditem_id)
);

-- 10. foodorder
CREATE TABLE foodorder (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount REAL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- 11. booking
CREATE TABLE booking (
    booking_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    show_id INTEGER,
    booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount REAL,
    status TEXT,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (show_id) REFERENCES showtable(show_id)
);

-- 12. showseat
CREATE TABLE showseat (
    showseat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    show_id INTEGER,
    seat_id INTEGER,
    is_booked INTEGER DEFAULT 0,
    FOREIGN KEY (show_id) REFERENCES showtable(show_id),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
);

-- 13. ticket
CREATE TABLE ticket (
    ticket_id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER,
    seat_id INTEGER,
    price REAL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
);

-- 14. foodorderitem
CREATE TABLE foodorderitem (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    size_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES foodorder(order_id),
    FOREIGN KEY (size_id) REFERENCES fooditemsize(size_id)
);

-- 15. review
CREATE TABLE review (
    review_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    movie_id INTEGER,
    rating INTEGER,
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- 16. pointstransaction
CREATE TABLE pointstransaction (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    points INTEGER,
    transaction_type TEXT,
    transaction_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- 17. moviecast
CREATE TABLE moviecast (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER,
    actor_name TEXT,
    role_name TEXT,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

-- 18. payment
CREATE TABLE payment (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER,
    gateway_id INTEGER,
    amount REAL,
    payment_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TEXT,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (gateway_id) REFERENCES paymentgateway(gateway_id)
);
