DROP DATABASE IF EXISTS calgary_art;
CREATE DATABASE calgary_art;
USE calgary_art;

CREATE TABLE users(
    id INTEGER AUTO_INCREMENT PRIMARY KEY, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    hashed_password VARCHAR(255) NOT NULL, 
    f_name VARCHAR(255) NOT NULL, 
    l_name VARCHAR(255) NOT NULL, 
    avatar_URL VARCHAR(255), 
    created_at TIMESTAMP DEFAULT NOW() 
);

CREATE TABLE artists(
    id INTEGER AUTO_INCREMENT PRIMARY KEY, 
    user_id INTEGER NOT NULL,
    bio TEXT(3000), 
    created_at TIMESTAMP DEFAULT NOW(), 
    FOREIGN KEY(user_id) REFERENCES users(id)  ON DELETE CASCADE
);
CREATE TABLE venues(
    id INTEGER AUTO_INCREMENT PRIMARY KEY, 
    b_name VARCHAR(255) NOT NULL, 
    b_phone VARCHAR(15), 
    b_address VARCHAR(255) NOT NULL, 
    address_URL VARCHAR(255), 
    created_at TIMESTAMP DEFAULT NOW(), 
    creator_id INTEGER NOT NULL,
    FOREIGN KEY(creator_id) REFERENCES users(id) 
);

CREATE TABLE art_pieces(
    id INTEGER AUTO_INCREMENT PRIMARY KEY, 
    ap_name VARCHAR(255) NOT NULL, 
    ap_description TEXT(3000),
    ap_price DECIMAL(15,2),
    ap_picture_URL VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(), 
    artist_id INTEGER NOT NULL,
    FOREIGN KEY(artist_id) REFERENCES artists(id)  ON DELETE CASCADE
);

CREATE TABLE exhibitions(
    id INTEGER AUTO_INCREMENT PRIMARY KEY, 
    venue_id INTEGER NOT NULL,
    ap_id INTEGER NOT NULL,
    date_from DATETIME,
    date_to DATETIME,
    created_at TIMESTAMP DEFAULT NOW(), 
    creator_id INTEGER NOT NULL,
    FOREIGN KEY(venue_id) REFERENCES venues(id) ON DELETE CASCADE,
    FOREIGN KEY(ap_id) REFERENCES art_pieces(id) ON DELETE CASCADE,
    FOREIGN KEY(creator_id) REFERENCES users(id)
);

SOURCE users_seed.sql;
SOURCE artists_seed.sql;
SOURCE venues_seed.sql;
SOURCE art_pieces_seed.sql;
SOURCE exhibitions.sql




-- SELECT f_name, l_name, bio FROM users JOIN artists ON users.id = artists.user_id;
-- SELECT f_name, b_name FROM users JOIN venues ON users.id = venues.creator_id;
-- SELECT f_name, ap_name FROM users 
--     JOIN artists 
--     ON users.id = artists.user_id
--     JOIN art_pieces
--     ON artists.id = art_pieces.artist_id
--     WHERE artists.id =2;

-- SELECT ap_name, f_name, b_name FROM exhibitions
-- JOIN art_pieces
--     ON art_pieces.id = exhibitions.ap_id
-- JOIN artists
--     ON artists.id = art_pieces.artist_id
-- JOIN users
--     ON users.id = artists.user_id
-- JOIN venues
--     ON venues.id = exhibitions.venue_id;


-- SELECT f_name, ap_name FROM users
--      JOIN artists ON users.id = artists.user_id
--      JOIN art_pieces ON artists.id = art_pieces.artist_id
--      WHERE artists.id = 2 GROUP BY artists.id;
