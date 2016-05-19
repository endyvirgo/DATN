var possibleForceValues: Set<CGFloat> = []

func touchUpdatedHandler(touch: UITouch) {
    let preInsertionLength = possibleForceValues.count
    possibleForceValues.insert(touch.force)
    let postInsertionLength = possibleForceValues.count
    if postInsertionLength - preInsertionLength == 1 {
        print("inserted unique force: \(touch.force)")
    }
}
