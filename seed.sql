-- seed.sql
INSERT INTO borrowers VALUES
(1, 'Avery Johnson', 742, 'NC'),
(2, 'Jordan Lee', 698, 'SC'),
(3, 'Morgan Smith', 781, 'NC'),
(4, 'Taylor Brown', 655, 'GA'),
(5, 'Casey Davis', 720, 'VA'),
(6, 'Riley Wilson', 705, 'TN');


INSERT INTO loans VALUES
(101, 1, 325000.00, 6.375, 'Locked', '30Y Fixed', 115),
(102, 2, 240000.00, 6.750, 'Floating', '30Y Fixed', 90),
(103, 3, 510000.00, 6.125, 'Locked', '15Y Fixed', 135),
(104, 4, 185000.00, 7.125, 'Expired', 'FHA', 70),
(105, 5, 405000.00, 6.500, 'Locked', '30Y Fixed', 105),
(106, 1, 275000.00, 6.625, 'Floating', 'ARM', 100);
