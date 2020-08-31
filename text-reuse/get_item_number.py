from math import floor


this_iter = 849
this_item = 36
this_qpi = 100

final_item = this_iter * this_qpi + this_item


def get_item_number(qpi, iter_number, item_number):
    final_item = iter_number * qpi + item_number
    return final_item


def get_iter_number(qpi, whole_item_number):
    return floor(whole_item_number / qpi)

