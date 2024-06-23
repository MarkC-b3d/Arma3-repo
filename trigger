condition
(fieldSpawn getVariable ["activated", false])


activation:
_numEnemies = 30;

_spawnPositions = [
    [10, 0, 0], [-10, 0, 0], [0, 10, 0], [0, -10, 0],
    [15, 15, 0], [-15, -15, 0], [15, -15, 0], [-15, 15, 0],
    [20, 0, 0], [0, 20, 0],
    [25, 10, 0], [-25, -10, 0], [10, 25, 0], [-10, -25, 0],
    [30, 0, 0], [-30, 0, 0], [0, 30, 0], [0, -30, 0],
    [35, 15, 0], [-35, -15, 0], [15, 35, 0], [-15, -35, 0],
    [40, 0, 0], [-40, 0, 0], [0, 40, 0], [0, -40, 0],
    [45, 15, 0], [-45, -15, 0], [15, 45, 0], [-15, -45, 0],
    [50, 0, 0], [0, 50, 0]
];

_enemies = [];

_triggerPos = getPos thisTrigger;

for "_i" from 0 to (_numEnemies - 1) do {
    _spawnPos = _triggerPos vectorAdd (_spawnPositions select (_i % (count _spawnPositions)));
    _enemy = createGroup EAST createUnit ["O_Soldier_F", _spawnPos, [], 0, "FORM"];
    _enemy setBehaviour "SAFE"; 
    _enemy setFormation "STAG COLUMN";  
    _enemy setSpeedMode "LIMITED";   
    _enemies pushBack _enemy;
};

_patrol = {
    params ["_unit"];
    while {alive _unit} do {
        _patrolPos = [_unit, 50, 100, 5, 0, 20, 0] call BIS_fnc_findSafePos;
        _unit doMove _patrolPos;
        sleep (random [5, 10, 15]);
    };
};

{
    [_x] spawn _patrol;
} forEach _enemies;


