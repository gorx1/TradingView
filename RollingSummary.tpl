//@version=4
study("Rolling summary", overlay=true)

// inputs
length = input(50)
source = input(close)
p1 = input(9, title="Add. percentile 1")
p2 = input(91, title="Add. percentile 2")
p3 = input(2, title="Add. percentile 3")
p4 = input(98, title="Add. percentile 4")

ls = input(false, title="Log-space")
src = ls == true?log(source):source

mean = sma(src, length)
median = percentile_nearest_rank(src, length, 50)
q1 = percentile_nearest_rank(src, length, 25)
q3 = percentile_nearest_rank(src, length, 75)
iqr = q3 - q1
upper_whisker = q3 + 1.5 * iqr
lower_whisker = q1 - 1.5 * iqr
c_p1 = percentile_nearest_rank(src,length,p1)
c_p2 = percentile_nearest_rank(src,length,p2)
c_p3 = percentile_nearest_rank(src,length,p3)
c_p4 = percentile_nearest_rank(src,length,p4)

p_mean = plot(ls == true?exp(mean):mean, color=#9C27B0, title="Mean", display=display.none)
p_median = plot(ls == true?exp(median):median, color=#E10E54, title="Median")
p_q1 = plot(ls == true?exp(q1):q1, color=#138484, title="Q1")
p_q3 = plot(ls == true?exp(q3):q3, color=#138484, title="Q3")
p_p1 = plot(ls == true?exp(c_p1):c_p1, color=#138484, title="Add. percentile 1", display=display.none)
p_p2 = plot(ls == true?exp(c_p2):c_p2, color=#138484, title="Add. percentile 2", display=display.none)
p_p3 = plot(ls == true?exp(c_p3):c_p3, color=#138484, title="Add. percentile 3", display=display.none)
p_p4 = plot(ls == true?exp(c_p4):c_p4, color=#138484, title="Add. percentile 4", display=display.none)
p_upper_whisker = plot(ls == true?exp(upper_whisker):upper_whisker, title="Upper whisker", color=#787B86, transp=0)
p_lower_whisker = plot(ls == true?exp(lower_whisker):lower_whisker, title="Lower whisker", color=#787B86, transp=0)
fill(p_q1, p_q3, color=#138484)  
