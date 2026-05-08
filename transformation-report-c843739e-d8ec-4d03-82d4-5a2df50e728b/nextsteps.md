# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality, such as product listings, cart operations, and any checkout flows, behave as expected.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing logic has not been broken during transformation:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether the failures are due to transformation-related changes or pre-existing issues.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain Windows-specific or legacy APIs that were available in .NET Framework. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (these are not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- `ConfigurationManager` — replace with `IConfiguration` from `Microsoft.Extensions.Configuration`
- `BinaryFormatter` — this is disabled by default in modern .NET due to security concerns

### 7. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correctly configured for the target environment and that the data access layer functions correctly at runtime.

### 8. Review Static Files and wwwroot

Ensure that all static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is self-contained and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present, then deploy the contents to your target hosting environment.