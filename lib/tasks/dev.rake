desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do

FootballTeam.destroy_all

a = FootballTeam.new
a.team_name = "Arizona Cardinals"
a.save

b = FootballTeam.new
b.team_name = "Atlanta Falcons"
b.save

c = FootballTeam.new
c.team_name = "Baltimore Ravens"
c.save

d = FootballTeam.new
d.team_name = "Buffalo Bills"
d.save

e = FootballTeam.new
e.team_name = "Carolina Panthers"
e.save

f = FootballTeam.new
f.team_name = "Chicago Bears"
f.save

g = FootballTeam.new
g.team_name = "Cincinnati Bengals"
g.save

h = FootballTeam.new
h.team_name = "Cleveland Browns"
h.save

i = FootballTeam.new
i.team_name = "Dallas Cowboys"
i.save

j = FootballTeam.new
j.team_name = "Denver Broncos"
j.save

k = FootballTeam.new
k.team_name = "Detroit Lions"
k.save

l = FootballTeam.new
l.team_name = "Green Bay Packers"
l.save

m = FootballTeam.new
m.team_name = "Houston Texans"
m.save

n = FootballTeam.new
n.team_name = "Indianapolis Colts"
n.save

o = FootballTeam.new
o.team_name = "Jacksonville Jaguars"
o.save

p = FootballTeam.new
p.team_name = "Kansas City Chiefs"
p.save

q = FootballTeam.new
q.team_name = "Los Angeles Chargers"
q.save

r = FootballTeam.new
r.team_name = "Los Angeles Rams"
r.save

s = FootballTeam.new
s.team_name = "Miami Dolphins"
s.save

t = FootballTeam.new
t.team_name = "Minnesota Vikings"
t.save

u = FootballTeam.new
u.team_name = "New England Patriots"
u.save

v = FootballTeam.new
v.team_name = "New Orleans Saints"
v.save

w = FootballTeam.new
w.team_name = "New York Giants"
w.save

x = FootballTeam.new
x.team_name = "New York Jets"
x.save

y = FootballTeam.new
y.team_name = "Oakland Raiders"
y.save

z = FootballTeam.new
z.team_name = "Philadelphia Eagles"
z.save

aa = FootballTeam.new
aa.team_name = "Pittsburgh Steelers"
aa.save

ab = FootballTeam.new
ab.team_name = "San Francisco 49ers"
ab.save

ac = FootballTeam.new
ac.team_name = "Seattle Seahawks"
ac.save

ad = FootballTeam.new
ad.team_name = "Tampa Bay Buccaneers"
ad.save

ae = FootballTeam.new
ae.team_name = "Tennessee Titans"
ae.save

af = FootballTeam.new
af.team_name = "Washington Football Team"
af.save


end
