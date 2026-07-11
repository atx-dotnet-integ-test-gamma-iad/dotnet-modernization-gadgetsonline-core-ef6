# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions have reached end of life.

### 4. Run the Test Suite

If the solution contains any test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failures before proceeding to deployment.

### 5. Run the Application Locally

Start the application locally to confirm it runs as expected on the new .NET runtime:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually exercise the key areas of the application, particularly any functionality that relied on Windows-specific APIs in the legacy project, such as authentication, file I/O, or database access.

### 6. Check for Removed or Changed APIs

Use the .NET Upgrade Assistant compatibility analyzer or review the [.NET API compatibility documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) to identify any APIs that may have been removed or changed between the legacy .NET Framework version and the current .NET version. Pay particular attention to:

- `System.Web` usages, which are not available in cross-platform .NET
- Windows Communication Foundation (WCF) server-side components
- Any third-party libraries that may not have cross-platform compatible versions

### 7. Publish the Application

Once the application has been validated locally, publish it using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files and assets are present before deploying to the target environment.