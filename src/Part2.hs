module Part2 where

import Part2.Types

------------------------------------------------------------
-- PROBLEM #6
--
-- Написать функцию, которая преобразует значение типа
-- ColorLetter в символ, равный первой букве значения
prob6 :: ColorLetter -> Char
prob6 RED = 'R'
prob6 GREEN = 'G'
prob6 BLUE = 'B'

------------------------------------------------------------
-- PROBLEM #7
--
-- Написать функцию, которая проверяет, что значения
-- находятся в диапазоне от 0 до 255 (границы входят)
prob7 :: ColorPart -> Bool
prob7 c = case c of
  Red x -> x >= 0 && x < 255
  Green x -> x >= 0 && x < 255
  Blue x -> x >= 0 && x < 255

------------------------------------------------------------
-- PROBLEM #8
--
-- Написать функцию, которая добавляет в соответствующее
-- поле значения Color значение из ColorPart
prob8 :: Color -> ColorPart -> Color
prob8 c p = case p of
  Red x -> c {red = red c + x}
  Green x -> c {green = green c + x}
  Blue x -> c {blue = blue c + x}

------------------------------------------------------------
-- PROBLEM #9
--
-- Написать функцию, которая возвращает значение из
-- ColorPart
prob9 :: ColorPart -> Int
prob9 c = case c of
  Red x -> x
  Green x -> x
  Blue x -> x

------------------------------------------------------------
-- PROBLEM #10
--
-- Написать функцию, которая возвращает компонент Color, у
-- которого наибольшее значение (если такой единственный)
prob10 :: Color -> Maybe ColorPart
prob10 c | red c > green c && red c > blue c = Just  (Red (red c))
         | green c > red c && green c > blue c = Just  (Green (green c))
         | blue c > red c && blue c > green c = Just  (Blue (blue c))
prob10 c = Nothing

------------------------------------------------------------
-- PROBLEM #11
--
-- Найти сумму элементов дерева
prob11 :: Num a => Tree a -> a
prob11 tree =
    root tree +
    fmap prob11 (left tree) `orElse` 0 +
    fmap prob11 (right tree) `orElse` 0

orElse :: Maybe a -> a -> a
orElse (Just x) _ = x
orElse Nothing x = x

------------------------------------------------------------
-- PROBLEM #12
--
-- Проверить, что дерево является деревом поиска
-- (в дереве поиска для каждого узла выполняется, что все
-- элементы левого поддерева узла меньше элемента в узле,
-- а все элементы правого поддерева -- не меньше элемента
-- в узле)
prob12 :: Ord a => Tree a -> Bool
prob12 = checkTree

checkTree :: Ord a => Tree a -> Bool
checkTree tree = checkLeft (left tree) (root tree) && checkRight (right tree) (root tree)

checkRight :: Ord a => Maybe (Tree a) -> a -> Bool
checkRight Nothing x = True
checkRight (Just tree) parent = root tree >= parent && checkTree tree

checkLeft :: Ord a => Maybe (Tree a) -> a -> Bool
checkLeft Nothing x = True
checkLeft (Just tree) parent = root tree < parent && checkTree tree

------------------------------------------------------------
-- PROBLEM #13
--
-- На вход подаётся значение и дерево поиска. Вернуть то
-- поддерево, в корне которого находится значение, если оно
-- есть в дереве поиска; если его нет - вернуть Nothing
prob13 :: Ord a => a -> Tree a -> Maybe (Tree a)
prob13 v tree = search v (Just tree)

search :: Ord a => a -> Maybe (Tree a) -> Maybe (Tree a)
search _ Nothing = Nothing
search value t@(Just (Tree l root r))
    | value == root = t
    | value < root = search value l
    | value > root = search value r

------------------------------------------------------------
-- PROBLEM #14
--
-- Заменить () на числа в порядке обхода "правый, левый,
-- корень", начиная с 1
prob14 :: Tree () -> Tree Int
prob14 t = case enumerate (Just t) 1 of
    (Just enumerated, _) -> enumerated

enumerate :: Maybe (Tree ()) -> Int -> (Maybe (Tree Int), Int)
enumerate Nothing i = (Nothing, i)
enumerate (Just (Tree l () r)) i = (Just $ Tree l' current r', current + 1)
    where
        (r', afterRight) = enumerate r i
        (l', afterLeft) = enumerate l afterRight
        current = afterLeft

------------------------------------------------------------
-- PROBLEM #15
--
-- Выполнить вращение дерева влево относительно корня
-- (https://en.wikipedia.org/wiki/Tree_rotation)
prob15 :: Tree a -> Tree a
prob15 (Tree a p (Just (Tree b q c))) = Tree (Just $ Tree a p b) q c
prob15 _ = error "Tree has too few nodes to rotate"

------------------------------------------------------------
-- PROBLEM #16
--
-- Выполнить вращение дерева вправо относительно корня
-- (https://en.wikipedia.org/wiki/Tree_rotation)
prob16 :: Tree a -> Tree a
prob16 (Tree (Just (Tree a p b)) q c) = Tree a p (Just $ Tree b q c)
prob16 _ = error "Tree has too few nodes to rotate"

------------------------------------------------------------
-- PROBLEM #17
--
-- Сбалансировать дерево поиска так, чтобы для любого узла
-- разница высот поддеревьев не превосходила по модулю 1
-- (например, преобразовать в полное бинарное дерево)
prob17 :: Tree a -> Tree a
prob17 = error "Implement me!"