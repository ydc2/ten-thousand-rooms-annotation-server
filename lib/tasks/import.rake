namespace :import do

  desc "imports annotationList data from a csv file"
  task :annotationList => :environment do
    require 'csv'
    CSV.foreach('importData/AnnoList.csv') do |row|
      #id = row[0]
      list_id = row[1]
      list_type = row[2]
      resources = row[3]
      within = row[4]
      puts row.inspect
      puts "List_id: ",list_id,"Resources: ",resources, "Within", within
      @annotationList = AnnotationList.create(list_id: list_id, list_type: list_type, within: within, resources: resources)
      @annotationList.save!(options={validate: false})
      puts "annoList.within = ", @annotationList.within
    end
  end

  desc "imports annotationLayer data from a csv file"
  task :annotationLayer => :environment do
    @layer = AnnotationLayer.first
    #puts @layer.attribute_names
    require 'csv'
    CSV.foreach('importData/AnnoLayers.csv') do |row|
      #id = row[0]
      layer_id = row[1]
      layer_type = row[2]
      label = row[4]
      motivation = row[5]
      #description = row[6]
      license = row[7]
      otherContent = row[8]
      puts row.inspect
      puts "Layer_id: ",layer_id,"Label: ",label, "otherContent: ", otherContent
      @annotationLayer = AnnotationLayer.create(layer_id: layer_id, layer_type: layer_type, label: label, otherContent: otherContent, motivation: motivation, license: license)
      puts @annotationLayer.attribute_names.to_s
      puts @annotationLayer.attributes.to_s
      @annotationLayer.save!(options={validate: false})
      puts "annoLayer.otherContent = ", @annotationLayer.otherContent
      puts "annoLayer.label = ", @annotationLayer.label
    end
  end

  desc "imports annotation data from a csv file"
  task :annotation => :environment do
    require 'csv'
    CSV.foreach('importData/Annos.csv') do |row|
      id = row[0]
      annotation_id = row[1]
      annotation_type = row[2]
      on = row[3]
      canvas = row[4]
      motivation = row[6]
      resource = row[7]
      active = row[10]
      version = row[11]
      puts row.inspect
      puts "Id: ", id,"Annotation_id: ",annotation_id,"On: ",on, "Motivation", motivation, "Resource: ", resource
      @annotation = Annotation.create(annotation_id: annotation_id, annotation_type: annotation_type, on: on, canvas: canvas, motivation: motivation, active: active, version: version)
      result = @annotation.save!(options={validate: false})
      p 'save result: ' + result.to_s
      #puts "anno.motivation= ", @annotation.motivation
    end
  end

  desc "imports LayerListsMaps data from a csv file"
  task :layerListsMaps => :environment do
    require 'csv'
    CSV.foreach('importData/LayerListsMaps.csv') do |row|
      id = row[0]
      layer_id = row[1]
      sequence = row[2]
      list_id = row[3]
      puts row.inspect
      puts "Id: ", id,"Layer_id: ", layer_id, "Sequence ", sequence,"List_Id: ", list_id
      @layerListsMap = LayerListsMap.create(id: id, layer_id: layer_id, sequence: sequence, list_id: list_id)
      #@layerListsMap.save!(options={validate: false})
      puts "@layerListsMap.sequence = ", @layerListsMap.sequence
    end
  end

  desc "imports ListAnnotationssMaps data from a csv file"
  task :listAnnotationMaps => :environment do
    require 'csv'
    CSV.foreach('importData/ListAnnotationsMaps.csv') do |row|
      id = row[0]
      list_id_in = row[1]
      sequence = row[2].to_i
      annotation_id = row[3]
      puts row.inspect
      puts "Id: ", id,"List_id: ", list_id_in, "Sequence ", sequence,"Annotation_Id: ", annotation_id
      @listAnnotationsMap = ListAnnotationsMap.create(list_id:list_id_in, sequence: sequence, annotation_id: annotation_id)

      puts @listAnnotationsMap.attributes.to_s
      @listAnnotationsMap.save!(options={validate: false})
      puts "@listAnnotationsMap.sequence = ", @listAnnotationsMap.sequence
    end
  end


end