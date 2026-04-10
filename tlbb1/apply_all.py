# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8')

fp = 'C:/Users/Administrator/Desktop/TLBB修改/tlbb/tlbb1/Server/Config/DropBoxContent.txt'
fp2 = 'C:/Users/Administrator/Desktop/TLBB修改/tlbb/tlbb1/Server/Config/MonsterDropBoxs.txt'

with open(fp, 'rb') as f:
    text = f.read().decode('gbk', errors='replace')
lines = text.split('\n')

with open(fp2, 'rb') as f:
    text2 = f.read().decode('gbk', errors='replace')
lines2 = text2.split('\n')

max_did = 0
for line in lines[3:]:
    c = line.split('\t')
    if c[0].strip() and c[0].strip().isdigit():
        max_did = max(max_did, int(c[0].strip()))
print('max_did:', max_did)

# ===== DropBoxContent modifications =====
# did -> [(col_idx, value), ...]
drops = {}

# Task 3: 辽兵/流寇 万灵石
drops['625'] = [(6, '20309011'), (7, '500')]
drops['1942'] = [(6, '20309012'), (7, '500')]

# Task 5: 余毒/红熊王 御赐套装
drops['17680'] = [(6, '10413003'), (7, '3000'), (8, '10412003'), (9, '3000')]
drops['17682'] = [(6, '10413004'), (7, '3000'), (8, '10412004'), (9, '3000')]
drops['17696'] = [(6, '10411003'), (7, '3000'), (8, '10421003'), (9, '3000')]
drops['17698'] = [(6, '10411004'), (7, '3000'), (8, '10421004'), (9, '3000')]

# Task 4: BOSS BoxValue + 套装/宝石/雕纹图样
boss_items_17024 = [(8, '10413003'), (9, '3000'), (10, '10512003'), (11, '3000'),
                    (12, '50101001'), (13, '2000'), (14, '30120012'), (15, '2000')]
boss_items_17964 = [(10, '10413004'), (11, '3000'), (12, '10511004'), (13, '3000'),
                    (14, '50101001'), (15, '2000'), (16, '30120012'), (17, '2000')]

# Apply existing box changes
for li in range(3, len(lines)):
    c = lines[li].split('\t')
    if not c[0].strip().isdigit():
        continue
    did = c[0]
    if did == '17024':
        c[1] = '34'
        drops[did] = boss_items_17024
    elif did == '17964':
        c[1] = '51'
        drops[did] = boss_items_17964
    if did in drops:
        for col_idx, val in drops[did]:
            if col_idx < len(c):
                c[col_idx] = val
        lines[li] = '\t'.join(c)

# New drop boxes: (DID, BoxValue, [item_id, weight, ...])
new_boxes = [
    (max_did+1, 160, ['20309011', '1000']),                    # 贼兵喽啰lv40 万灵石2级 Mvalue=8 -> 5%
    (max_did+2, 200, ['20309012', '1000']),                    # 贼兵喽啰lv50 万灵石3级 Mvalue=10 -> 5%
    (max_did+3, 640, ['20309011', '1000']),                    # 夺宝马贼lv41 万灵石2级 Mvalue=32 -> 5%
    (max_did+4, 820, ['20309012', '1000']),                    # 夺宝马贼lv51 万灵石3级 Mvalue=41 -> 5%
    (max_did+5, 50,  ['10511004', '2000', '10511034', '2000', '20310166', '1000']),  # 葛荣
    (max_did+6, 40, ['38010158', '-1']),                       # 山寨大王lv43 500元宝 Mvalue=16 -> 40%
    (max_did+7, 50, ['38010158', '-1']),                       # 山寨大王lv53 500元宝 Mvalue=20 -> 40%
    (max_did+8, 200, ['38003414', '-1']),                      # 远古棋魂lv44 珍兽蛋(蚀骨冥蛇40级) Mvalue=10 -> 5%
    (max_did+9, 200, ['38003415', '-1']),                      # 远古棋魂lv54 珍兽蛋(蚀骨冥蛇50级) Mvalue=10 -> 5%
    (max_did+10, 320, ['38003414', '-1']),                     # 山寨大王lv43 珍兽蛋(蚀骨冥蛇40级) Mvalue=16 -> 5%
    (max_did+11, 400, ['38003415', '-1']),                     # 山寨大王lv53 珍兽蛋(蚀骨冥蛇50级) Mvalue=20 -> 5%
]

for did, bv, items in new_boxes:
    fields = [str(did), str(bv), '-1', '0']
    for i in range(0, len(items), 2):
        fields.append(items[i])
        fields.append(items[i+1])
    while len(fields) < 517:
        fields.append('-1')
    lines.append('\t'.join(fields))
    print('New DID=%s BoxValue=%s items=%s' % (did, bv, items))

with open(fp, 'wb') as f:
    f.write('\n'.join(lines).encode('gbk', errors='replace'))
print('DropBoxContent saved OK, lines:', len(lines))

# ===== MonsterDropBoxs: add new DIDs =====
# monster_id -> [new_did, ...]  (one monster can link to multiple DIDs)
new_links = {
    '3643': [str(max_did+1)],                     # 贼兵喽啰lv40
    '3644': [str(max_did+2)],                     # 贼兵喽啰lv50
    '3513': [str(max_did+3)],                     # 夺宝马贼lv41
    '3514': [str(max_did+4)],                     # 夺宝马贼lv51
    '13983': [str(max_did+5)],                    # 愤怒的葛荣lv43
    '13984': [str(max_did+5)],                    # 愤怒的葛荣lv53
    '4133': [str(max_did+6), str(max_did+10)],    # 山寨大王lv43: 元宝+珍兽蛋
    '4134': [str(max_did+7), str(max_did+11)],    # 山寨大王lv53: 元宝+珍兽蛋
    '1853': [str(max_did+8)],                     # 远古棋魂lv44
    '1854': [str(max_did+9)],                     # 远古棋魂lv54
}

for mid, new_dids in new_links.items():
    found = False
    for li in range(2, len(lines2)):
        c = lines2[li].split('\t')
        if c[0] == mid:
            found = True
            mval = int(c[1])
            for new_did in new_dids:
                # Find first empty DID slot
                for j in range(3, 23):
                    if c[j] == '-1':
                        c[j] = new_did
                        lines2[li] = '\t'.join(c)
                        bv = -1
                        for ll in lines[3:]:
                            cc = ll.split('\t')
                            if cc[0] == new_did:
                                bv = int(cc[1])
                                break
                        rate = mval / bv * 100 if bv > 0 else 0
                        print('MonsterID=%s Mvalue=%s -> DID=%s BoxValue=%s rate=%.1f%%' % (mid, mval, new_did, bv, rate))
                        break
            break
    if not found:
        # Monster not in MonsterDropBoxs yet - need to create row
        # Get Mvalue from MonsterAttrExTable or use default
        with open('C:/Users/Administrator/Desktop/TLBB修改/tlbb/tlbb1/Public/Config/MonsterAttrExTable.txt', 'rb') as af:
            atext = af.read().decode('gbk', errors='replace')
        mval = 0
        for aline in atext.split('\n')[1:]:
            ac = aline.split('\t')
            if len(ac) > 1 and ac[0] == mid:
                mval = 10  # default Mvalue for monsters not in drop table
                break
        fields = [mid, str(mval), '1']
        # Fill DID slots
        for j in range(20):
            fields.append(str(new_dids[j]) if j < len(new_dids) else '-1')
        new_row = '\t'.join(fields)
        lines2.append(new_row)
        print('Created new row: MonsterID=%s Mvalue=%s DIDs=%s' % (mid, mval, new_dids))
        for new_did in new_dids:
            bv = -1
            for ll in lines[3:]:
                cc = ll.split('\t')
                if cc[0] == new_did:
                    bv = int(cc[1])
                    break
            rate = mval / bv * 100 if bv > 0 else 0
            print('  DID=%s BoxValue=%s rate=%.1f%%' % (new_did, bv, rate))

with open(fp2, 'wb') as f:
    f.write('\n'.join(lines2).encode('gbk', errors='replace'))
print('MonsterDropBoxs saved OK')
print('\nAll done!')
